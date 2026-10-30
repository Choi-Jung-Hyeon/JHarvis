# 레포 통합 (git subtree) 순서

이력을 보존한 채 두 레포를 하나로 합칩니다.

```bash
# 원본 레포는 건드리지 않는다. 새 레포에서:
git remote add <a> <원본 A URL> && git fetch <a>
git subtree add --prefix=<a_dir> <a> main
git remote add <b> <원본 B URL> && git fetch <b>
git subtree add --prefix=<b_dir> <b> main
# 확인: 원본 HEAD의 파일 해시와 통합본 하위 폴더 파일 해시를 대조
git ls-tree -r <a>/main | sort > a.txt
git ls-tree -r HEAD:<a_dir> | sort > a_in_hub.txt
diff a.txt a_in_hub.txt   # 차이가 없어야 한다
```
