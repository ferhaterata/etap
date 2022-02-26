; ModuleID = 'test/r/input/conditional-for-1.ll'
source_filename = "./input/conditional-for-1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @For1(i32 %x) #0 !distribution !2 !store !3 !formal !2 {
entry:
  %x.addr = alloca i32, align 4, !store !4
  %result = alloca i32, align 4, !store !5
  %i = alloca i32, align 4, !store !6
  store i32 %x, i32* %x.addr, align 4, !store !7
  store i32 0, i32* %result, align 4, !store !8
  %0 = load i32, i32* %x.addr, align 4, !store !9
  store i32 %0, i32* %i, align 4, !store !10
  br label %for.cond, !store !11

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4, !store !12
  %cmp = icmp sle i32 %1, 5, !store !13
  br i1 %cmp, label %for.body, label %for.end, !store !14

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %result, align 4, !store !15
  %add = add nsw i32 %2, 1, !store !16
  store i32 %add, i32* %result, align 4, !store !17
  br label %for.inc, !store !18

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4, !store !19
  %inc = add nsw i32 %3, 1, !store !20
  store i32 %inc, i32* %i, align 4, !store !21
  br label %for.cond, !store !11

for.end:                                          ; preds = %for.cond
  %4 = load i32, i32* %result, align 4, !store !22
  ret i32 %4, !store !23
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"x <- DiscreteDistribution(supp = 0:4)"}
!3 = !{!"entry <- F; for.cond <- F; for.body <- F; for.inc <- F; for.end <- F"}
!4 = !{!"p.x.addr <- alloca(\\\22int\\\22)"}
!5 = !{!"p.result <- alloca(\\\22int\\\22)"}
!6 = !{!"p.i <- alloca(\\\22int\\\22)"}
!7 = !{!"store(x, p.x.addr)"}
!8 = !{!"store(0, p.result)"}
!9 = !{!"v.0 <- load(p.x.addr)"}
!10 = !{!"store(v.0, p.i)"}
!11 = !{!"br(quote(for.cond))"}
!12 = !{!"v.1 <- load(p.i)"}
!13 = !{!"v.cmp <- icmp(sle, v.1, 5)"}
!14 = !{!"br(quote(for.body), quote(for.end), v.cmp)"}
!15 = !{!"v.2 <- load(p.result)"}
!16 = !{!"v.add <- add(v.2, 1)"}
!17 = !{!"store(v.add, p.result)"}
!18 = !{!"br(quote(for.inc))"}
!19 = !{!"v.3 <- load(p.i)"}
!20 = !{!"v.inc <- add(v.3, 1)"}
!21 = !{!"store(v.inc, p.i)"}
!22 = !{!"v.4 <- load(p.result)"}
!23 = !{!"path.return <<- c(path.return, ret(v.4)); for.end <- T; for.cond <- F"}
