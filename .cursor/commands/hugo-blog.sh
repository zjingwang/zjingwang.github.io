#!/bin/bash

# Hugo 博客管理命令
# 功能：补充文档、预览文档、推送文档

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 项目根目录
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT"

# 显示帮助信息
show_help() {
    echo -e "${BLUE}Hugo 博客管理命令${NC}"
    echo ""
    echo "用法: $0 [命令] [选项]"
    echo ""
    echo "命令:"
    echo "  create, c    创建新文档/文章/页面"
    echo "  preview, p   启动本地预览服务器"
    echo "  deploy, d    部署到 GitHub"
    echo "  help, h      显示帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 create docs my-topic details my-doc"
    echo "  $0 create posts my-article"
    echo "  $0 preview"
    echo "  $0 deploy \"feat: 添加新文档\""
}

# 显示交互式菜单
show_menu() {
    echo -e "${BLUE}╔══════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║     Hugo 博客管理命令 - 主菜单      ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${GREEN}请选择要执行的操作:${NC}"
    echo ""
    echo -e "  ${YELLOW}1)${NC} 创建新文档 (docs)"
    echo -e "  ${YELLOW}2)${NC} 创建新文章 (posts)"
    echo -e "  ${YELLOW}3)${NC} 创建新页面 (homepage)"
    echo -e "  ${YELLOW}4)${NC} 预览网站 (启动开发服务器)"
    echo -e "  ${YELLOW}5)${NC} 部署到 GitHub"
    echo -e "  ${YELLOW}6)${NC} 显示帮助信息"
    echo -e "  ${YELLOW}0)${NC} 退出"
    echo ""
    echo -n -e "${GREEN}请输入选项 [0-6]: ${NC}"
}

# 创建新文档
create_document() {
    local type=$1
    shift
    local path_parts=("$@")
    local path="${path_parts[*]}"
    path="${path// //}"
    
    case $type in
        docs|doc|d)
            if [ -z "$path" ]; then
                echo -e "${RED}错误: 请提供文档路径${NC}"
                echo "示例: $0 create docs my-topic details my-doc"
                exit 1
            fi
            echo -e "${GREEN}创建文档: docs/$path.md${NC}"
            hugo new "docs/$path.md"
            ;;
        posts|post|p)
            if [ -z "$path" ]; then
                echo -e "${RED}错误: 请提供文章名称${NC}"
                echo "示例: $0 create posts my-article"
                exit 1
            fi
            echo -e "${GREEN}创建文章: posts/$path.md${NC}"
            hugo new "posts/$path.md"
            ;;
        pages|page|pg)
            if [ -z "$path" ]; then
                echo -e "${RED}错误: 请提供页面名称${NC}"
                echo "示例: $0 create pages my-page"
                exit 1
            fi
            echo -e "${GREEN}创建页面: homepage/$path.md${NC}"
            hugo new "homepage/$path.md"
            ;;
        *)
            echo -e "${RED}错误: 未知的文档类型 '$type'${NC}"
            echo "支持的类型: docs, posts, pages"
            exit 1
            ;;
    esac
    
    echo -e "${GREEN}✓ 文档创建成功！${NC}"
    echo -e "${YELLOW}提示: 编辑文件后使用 '$0 preview' 预览${NC}"
}

# 预览文档
preview_document() {
    local include_drafts=false
    local port=1313
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -D|--drafts)
                include_drafts=true
                shift
                ;;
            -p|--port)
                port=$2
                shift 2
                ;;
            *)
                echo -e "${RED}未知选项: $1${NC}"
                exit 1
                ;;
        esac
    done
    
    echo -e "${GREEN}启动 Hugo 开发服务器...${NC}"
    echo -e "${BLUE}访问地址: http://localhost:$port${NC}"
    
    if [ "$include_drafts" = true ]; then
        hugo server -D -p "$port"
    else
        hugo server -p "$port"
    fi
}

# 部署到 GitHub
deploy_document() {
    local commit_message="$1"
    
    if [ -z "$commit_message" ]; then
        echo -e "${YELLOW}请输入提交信息（使用 Angular 规范）:${NC}"
        echo "示例: feat: 添加新文档"
        read -r commit_message
    fi
    
    if [ -z "$commit_message" ]; then
        echo -e "${RED}错误: 提交信息不能为空${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}检查 Git 状态...${NC}"
    if ! git diff --quiet || ! git diff --cached --quiet; then
        echo -e "${GREEN}添加更改到暂存区...${NC}"
        git add .
        
        echo -e "${GREEN}提交更改...${NC}"
        git commit -m "$commit_message"
        
        echo -e "${GREEN}推送到 GitHub...${NC}"
        git push origin main
        
        echo -e "${GREEN}✓ 部署成功！${NC}"
        echo -e "${YELLOW}GitHub Actions 将自动构建和部署到 GitHub Pages${NC}"
        echo -e "${BLUE}查看部署状态: https://github.com/zjingwang/zjingwang.github.io/actions${NC}"
    else
        echo -e "${YELLOW}没有需要提交的更改${NC}"
    fi
}

# 交互式创建文档
interactive_create() {
    local type=$1
    echo ""
    case $type in
        docs)
            echo -n -e "${GREEN}请输入文档路径 (例如: java/details/java-day-3): ${NC}"
            read -r path
            if [ -z "$path" ]; then
                echo -e "${RED}错误: 路径不能为空${NC}"
                return 1
            fi
            create_document docs $path
            ;;
        posts)
            echo -n -e "${GREEN}请输入文章名称 (例如: my-article): ${NC}"
            read -r path
            if [ -z "$path" ]; then
                echo -e "${RED}错误: 文章名称不能为空${NC}"
                return 1
            fi
            create_document posts $path
            ;;
        pages)
            echo -n -e "${GREEN}请输入页面名称 (例如: my-page): ${NC}"
            read -r path
            if [ -z "$path" ]; then
                echo -e "${RED}错误: 页面名称不能为空${NC}"
                return 1
            fi
            create_document pages $path
            ;;
    esac
}

# 主函数
main() {
    local command=$1
    shift
    
    # 如果没有提供命令，显示交互式菜单
    if [ -z "$command" ]; then
        while true; do
            show_menu
            read -r choice
            echo ""
            
            case $choice in
                1)
                    interactive_create docs
                    echo ""
                    echo -n -e "${YELLOW}按 Enter 继续...${NC}"
                    read
                    ;;
                2)
                    interactive_create posts
                    echo ""
                    echo -n -e "${YELLOW}按 Enter 继续...${NC}"
                    read
                    ;;
                3)
                    interactive_create pages
                    echo ""
                    echo -n -e "${YELLOW}按 Enter 继续...${NC}"
                    read
                    ;;
                4)
                    echo -e "${GREEN}启动预览服务器...${NC}"
                    preview_document
                    ;;
                5)
                    deploy_document
                    echo ""
                    echo -n -e "${YELLOW}按 Enter 继续...${NC}"
                    read
                    ;;
                6)
                    show_help
                    echo ""
                    echo -n -e "${YELLOW}按 Enter 继续...${NC}"
                    read
                    ;;
                0)
                    echo -e "${GREEN}退出${NC}"
                    exit 0
                    ;;
                *)
                    echo -e "${RED}无效选项，请重新选择${NC}"
                    sleep 1
                    ;;
            esac
        done
    fi
    
    # 命令行模式
    case $command in
        create|c)
            create_document "$@"
            ;;
        preview|p)
            preview_document "$@"
            ;;
        deploy|d)
            deploy_document "$@"
            ;;
        help|h)
            show_help
            ;;
        *)
            echo -e "${RED}错误: 未知命令 '$command'${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@"
