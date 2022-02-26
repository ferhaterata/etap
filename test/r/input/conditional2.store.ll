; ModuleID = 'test/r/input/conditional2.ll'
source_filename = "./input/conditional.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @conditional2(i32 %n) #0 !distribution !2 !store !3 !formal !2 {
entry:
  %retval = alloca i32, align 4, !store !4
  %n.addr = alloca i32, align 4, !store !5
  %xp = alloca i32*, align 8, !store !6
  store i32 %n, i32* %n.addr, align 4, !store !7
  store i32* %n.addr, i32** %xp, align 8, !store !8
  %0 = load i32, i32* %n.addr, align 4, !store !9
  %cmp = icmp sgt i32 %0, 1, !store !10
  br i1 %cmp, label %if.then, label %if.end3, !store !11

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %n.addr, align 4, !store !12
  %cmp1 = icmp sgt i32 %1, 2, !store !13
  br i1 %cmp1, label %if.then2, label %if.end, !store !14

if.then2:                                         ; preds = %if.then
  %2 = load i32*, i32** %xp, align 8, !store !15
  %3 = load i32, i32* %2, align 4, !store !16
  store i32 %3, i32* %retval, align 4, !store !17
  br label %return, !store !18

if.end:                                           ; preds = %if.then
  br label %if.end3, !store !19

if.end3:                                          ; preds = %if.end, %entry
  %4 = load i32*, i32** %xp, align 8, !store !20
  %5 = load i32, i32* %4, align 4, !store !21
  store i32 %5, i32* %retval, align 4, !store !22
  br label %return, !store !18

return:                                           ; preds = %if.end3, %if.then2
  %6 = load i32, i32* %retval, align 4, !store !23
  ret i32 %6, !store !24
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"n <- DiscreteDistribution(supp=1:4)"}
!3 = !{!"entry <- F; if.then <- F; if.then2 <- F; if.end <- F; if.end3 <- F; return <- F"}
!4 = !{!"p.retval <- alloca(\\\22int\\\22)"}
!5 = !{!"p.n.addr <- alloca(\\\22int\\\22)"}
!6 = !{!"p.xp <- alloca(\\\22int*\\\22)"}
!7 = !{!"store(n, p.n.addr)"}
!8 = !{!"store(p.n.addr, p.xp)"}
!9 = !{!"v.0 <- load(p.n.addr)"}
!10 = !{!"v.cmp <- icmp(sgt, v.0, 1)"}
!11 = !{!"br(quote(if.then), quote(if.end3), v.cmp)"}
!12 = !{!"v.1 <- load(p.n.addr)"}
!13 = !{!"v.cmp1 <- icmp(sgt, v.1, 2)"}
!14 = !{!"br(quote(if.then2), quote(if.end), v.cmp1)"}
!15 = !{!"p.2 <- load(p.xp)"}
!16 = !{!"v.3 <- load(p.2)"}
!17 = !{!"store(v.3, p.retval)"}
!18 = !{!"br(quote(return))"}
!19 = !{!"br(quote(if.end3))"}
!20 = !{!"p.4 <- load(p.xp)"}
!21 = !{!"v.5 <- load(p.4)"}
!22 = !{!"store(v.5, p.retval)"}
!23 = !{!"v.6 <- load(p.retval)"}
!24 = !{!"path.return <<- c(path.return, ret(v.6)); return <- T; if.end3 <- F; if.then2 <- F"}
