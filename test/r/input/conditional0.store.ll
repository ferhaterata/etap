; ModuleID = 'test/r/input/conditional0.ll'
source_filename = "./input/conditional.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @conditional0(i32 %n) #0 !distribution !2 !store !3 !formal !4 {
entry:
  %retval = alloca i32, align 4, !store !5
  %n.addr = alloca i32, align 4, !store !6
  store i32 %n, i32* %n.addr, align 4, !store !7
  %0 = load i32, i32* %n.addr, align 4, !store !8
  %sub = sub nsw i32 %0, 1, !store !9
  store i32 %sub, i32* %n.addr, align 4, !store !10
  %1 = load i32, i32* %n.addr, align 4, !store !11
  %cmp = icmp sgt i32 %1, 1, !store !12
  br i1 %cmp, label %if.then, label %if.end, !store !13, !update !14

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %n.addr, align 4, !store !15, !undo !16
  store i32 %2, i32* %retval, align 4, !store !17
  br label %return, !store !18

if.end:                                           ; preds = %entry
  %3 = load i32, i32* %n.addr, align 4, !store !19, !undo !20
  store i32 %3, i32* %retval, align 4, !store !21
  br label %return, !store !18

return:                                           ; preds = %if.end, %if.then
  %4 = load i32, i32* %retval, align 4, !store !22
  ret i32 %4, !store !23
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"n <- DiscreteDistribution(supp=1:4)"}
!3 = !{!"entry <- FALSE; if.then <- FALSE; if.end <- FALSE; return <- FALSE"}
!4 = !{!"sym$\\\22n\\\22 <- DiscreteDistribution(supp=1:4)"}
!5 = !{!"sym$\\\22retval\\\22 <- alloca(\\\22i32\\\22)"}
!6 = !{!"sym$\\\22n.addr\\\22 <- alloca(\\\22i32\\\22)"}
!7 = !{!"store(sym$\\\22n\\\22, sym$\\\22n.addr\\\22)"}
!8 = !{!"sym$\\\220\\\22 <- load(sym$\\\22n.addr\\\22)"}
!9 = !{!"sym$\\\22sub\\\22 <- sub(sym$\\\220\\\22, 1)"}
!10 = !{!"store(sym$\\\22sub\\\22, sym$\\\22n.addr\\\22)"}
!11 = !{!"sym$\\\221\\\22 <- load(sym$\\\22n.addr\\\22)"}
!12 = !{!"sym$\\\22cmp\\\22 <- icmp(sgt, sym$\\\221\\\22, 1)"}
!13 = !{!"br(if.then, if.end, sym$\\\22cmp\\\22)"}
!14 = !{!"{if (!is.numeric(sym$\\\221\\\22)) sym$\\\221\\\22 <- add(sym$\\\22cmp\\\22, 1)};store(sym$\\\221\\\22, sym$\\\22n.addr\\\22); "}
!15 = !{!"sym$\\\222\\\22 <- load(sym$\\\22n.addr\\\22)"}
!16 = !{!"if(entry) {sym$\\\22cmp\\\22 <- sym$\\\22cmp\\\22.true; {if (!is.numeric(sym$\\\221\\\22)) sym$\\\221\\\22 <- add(sym$\\\22cmp\\\22, 1)};store(sym$\\\221\\\22, sym$\\\22n.addr\\\22); };"}
!17 = !{!"store(sym$\\\222\\\22, sym$\\\22retval\\\22)"}
!18 = !{!"br(return)"}
!19 = !{!"sym$\\\223\\\22 <- load(sym$\\\22n.addr\\\22)"}
!20 = !{!"if(entry) {sym$\\\22cmp\\\22 <- sym$\\\22cmp\\\22.false; {if (!is.numeric(sym$\\\221\\\22)) sym$\\\221\\\22 <- add(sym$\\\22cmp\\\22, 1)};store(sym$\\\221\\\22, sym$\\\22n.addr\\\22); };"}
!21 = !{!"store(sym$\\\223\\\22, sym$\\\22retval\\\22)"}
!22 = !{!"sym$\\\224\\\22 <- load(sym$\\\22retval\\\22)"}
!23 = !{!"path.return <<- c(path.return, ret(sym$\\\224\\\22)); return <- TRUE; if.end <- FALSE; if.then <- FALSE"}
