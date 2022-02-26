; ModuleID = 'test/r/input/conditional1.ll'
source_filename = "./input/conditional.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @conditional1(i32 %n) #0 !distribution !2 !store !3 !formal !2 {
entry:
  %n.addr = alloca i32, align 4, !store !4
  store i32 %n, i32* %n.addr, align 4, !store !5
  %0 = load i32, i32* %n.addr, align 4, !store !6
  %cmp = icmp sgt i32 %0, 1, !store !7
  br i1 %cmp, label %if.then, label %if.end3, !store !8, !update !9

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %n.addr, align 4, !store !10, !undo !11
  %cmp1 = icmp sgt i32 %1, 2, !store !12
  br i1 %cmp1, label %if.then2, label %if.end, !store !13, !update !14

if.then2:                                         ; preds = %if.then
  br label %if.end, !store !15, !undo !16

if.end:                                           ; preds = %if.then2, %if.then
  br label %if.end3, !store !17, !undo !18

if.end3:                                          ; preds = %if.end, %entry
  %2 = load i32, i32* %n.addr, align 4, !store !19, !undo !20
  ret i32 %2, !store !21
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"n <- DiscreteDistribution(supp=1:4)"}
!3 = !{!"entry <- F; if.then <- F; if.then2 <- F; if.end <- F; if.end3 <- F"}
!4 = !{!"p.n.addr <- alloca(\\\22int\\\22)"}
!5 = !{!"store(n, p.n.addr)"}
!6 = !{!"v.0 <- load(p.n.addr)"}
!7 = !{!"v.cmp <- icmp(sgt, v.0, 1)"}
!8 = !{!"br(if.then, if.end3, v.cmp)"}
!9 = !{!"v.0 <- add(v.cmp, 1); store(v.0, p.n.addr); "}
!10 = !{!"v.1 <- load(p.n.addr)"}
!11 = !{!"if(entry) {v.cmp <- v.cmp.true; v.0 <- add(v.cmp, 1); store(v.0, p.n.addr); };"}
!12 = !{!"v.cmp1 <- icmp(sgt, v.1, 2)"}
!13 = !{!"br(if.then2, if.end, v.cmp1)"}
!14 = !{!"v.1 <- add(v.cmp1, 2); store(v.1, p.n.addr); "}
!15 = !{!"br(if.end)"}
!16 = !{!"if(if.then) {v.cmp1 <- v.cmp1.true; v.1 <- add(v.cmp1, 2); store(v.1, p.n.addr); };"}
!17 = !{!"br(if.end3)"}
!18 = !{!"if(if.then) {v.cmp1 <- v.cmp1.false; v.1 <- add(v.cmp1, 2); store(v.1, p.n.addr); };"}
!19 = !{!"v.2 <- load(p.n.addr)"}
!20 = !{!"if(entry) {v.cmp <- v.cmp.false; v.0 <- add(v.cmp, 1); store(v.0, p.n.addr); };"}
!21 = !{!"path.return <<- c(path.return, ret(v.2)); if.end3 <- T; if.end <- F; entry <- F"}
