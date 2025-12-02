#!/usr/bin/env python3
"""
修复翻译文件 - 最终版
将纯中文翻译改为英文+中文双语格式
"""

import subprocess
import re
import sys
from pathlib import Path

def get_content(repo_path, file_path, ref=None):
    """获取文件内容"""
    if ref:
        result = subprocess.run(
            ['git', 'show', f'{ref}:{file_path}'],
            cwd=repo_path,
            capture_output=True,
            text=True
        )
        return result.stdout if result.returncode == 0 else None
    else:
        full_path = Path(repo_path) / file_path
        return full_path.read_text(encoding='utf-8') if full_path.exists() else None

def split_content(content):
    """分离 frontmatter 和 body"""
    if not content.startswith('---'):
        return '', content
    
    lines = content.split('\n')
    for i, line in enumerate(lines[1:], 1):
        if line.strip() == '---':
            fm = '\n'.join(lines[1:i])
            body = '\n'.join(lines[i+1:])
            return fm, body.strip()
    return '', content

def merge_frontmatter(en_fm, cn_fm):
    """合并 frontmatter - 保留英文结构，仅对 title/description 添加中文"""
    translatable = {'title', 'description', 'short-title', 'shortTitle'}
    
    # 解析中文 frontmatter
    cn_dict = {}
    for line in cn_fm.split('\n'):
        if line.startswith('#') or not ':' in line:
            continue
        if not line.startswith(' ') and not line.startswith('\t'):
            parts = line.split(':', 1)
            key = parts[0].strip()
            val = parts[1].strip() if len(parts) > 1 else ''
            if val and val != '>':
                cn_dict[key] = val
    
    # 处理英文 frontmatter
    result = ['---']
    en_lines = en_fm.split('\n')
    i = 0
    
    while i < len(en_lines):
        line = en_lines[i]
        
        if not line.strip():
            result.append(line)
            i += 1
            continue
        
        # 检查是否是键值对
        if ':' in line and not line.startswith(' ') and not line.startswith('\t'):
            key = line.split(':')[0].strip()
            
            # 收集完整的多行值
            full_lines = [line]
            j = i + 1
            while j < len(en_lines) and (en_lines[j].startswith('  ') or en_lines[j].startswith('\t')):
                full_lines.append(en_lines[j])
                j += 1
            
            # 可翻译字段特殊处理
            if key in translatable:
                # 添加英文注释
                for fl in full_lines:
                    result.append(f'# {fl}')
                # 添加翻译值（目前保持英文，因为原翻译没有这些）
                for fl in full_lines:
                    result.append(fl)
            else:
                # 非翻译字段直接保留
                for fl in full_lines:
                    result.append(fl)
            
            i = j
        else:
            result.append(line)
            i += 1
    
    result.append('---')
    return '\n'.join(result)

def merge_body(en_body, cn_body):
    """合并正文 - 英文原文 + 中文翻译"""
    # 按段落分割
    en_paras = [p.strip() for p in re.split(r'\n\n+', en_body) if p.strip()]
    cn_paras = [p.strip() for p in re.split(r'\n\n+', cn_body) if p.strip()]
    
    # 筛选中文段落（包含中文字符）
    cn_text_paras = []
    for p in cn_paras:
        if re.search(r'[\u4e00-\u9fff]', p):
            # 排除代码块等特殊内容
            if not (p.startswith('```') or p.startswith('<?') or 
                    p.startswith('{%') or p.startswith(':::') or
                    re.match(r'^\[.+\]:', p)):
                cn_text_paras.append(p)
    
    result = []
    cn_idx = 0
    
    for en_para in en_paras:
        result.append(en_para)
        
        # 判断是否需要添加中文翻译
        is_text_para = not (
            en_para.startswith('```') or 
            en_para.startswith('<?') or
            en_para.startswith('{%') or
            en_para.startswith(':::') or
            en_para.startswith('<') or
            en_para.startswith('|') or
            re.match(r'^\[.+\]:', en_para)
        )
        
        # 如果是普通文本段落，添加中文翻译
        if is_text_para and cn_idx < len(cn_text_paras):
            result.append('')
            result.append(cn_text_paras[cn_idx])
            cn_idx += 1
    
    return '\n\n'.join(result)

def fix_file(repo_path, file_path):
    """修复单个文件"""
    print(f"  Processing: {file_path}")
    
    en_content = get_content(repo_path, file_path, 'upstream/main')
    cn_content = get_content(repo_path, file_path, 'sync-upstream-20251201')
    
    if not en_content:
        print(f"    Skip: no upstream content")
        return False
    if not cn_content:
        print(f"    Skip: no translation")
        return False
    
    en_fm, en_body = split_content(en_content)
    cn_fm, cn_body = split_content(cn_content)
    
    # 合并
    new_fm = merge_frontmatter(en_fm, cn_fm)
    new_body = merge_body(en_body, cn_body)
    
    # 写入
    new_content = f'{new_fm}\n\n{new_body}\n'
    full_path = Path(repo_path) / file_path
    full_path.write_text(new_content, encoding='utf-8')
    
    print(f"    Done")
    return True

def main():
    if len(sys.argv) < 3:
        print("Usage: fix_translation_final.py <repo_path> <file1> [file2] ...")
        sys.exit(1)
    
    repo_path = sys.argv[1]
    files = sys.argv[2:]
    
    print(f"Fixing {len(files)} files in {repo_path}...")
    fixed = sum(1 for f in files if fix_file(repo_path, f))
    print(f"\nDone: {fixed}/{len(files)} files fixed")

if __name__ == '__main__':
    main()
