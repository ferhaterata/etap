; ModuleID = 'test/r/input/conditional5.ll'
source_filename = "./input/conditional5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @conditional5(i32 %x, i32 %y) #0 !distribution !2 !distribution !3 !store !4 !formal !2 !formal !3 {
entry:
  %retval = alloca i32, align 4, !store !5
  %x.addr = alloca i32, align 4, !store !6
  %y.addr = alloca i32, align 4, !store !7
  store i32 %x, i32* %x.addr, align 4, !store !8
  store i32 %y, i32* %y.addr, align 4, !store !9
  %0 = load i32, i32* %x.addr, align 4, !store !10
  %cmp = icmp sgt i32 %0, 3, !store !11
  br i1 %cmp, label %if.then, label %if.end3, !store !12, !update !13

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %x.addr, align 4, !store !14, !undo !15
  %2 = load i32, i32* %y.addr, align 4, !store !16
  %sub = sub nsw i32 %1, %2, !store !17
  %cmp1 = icmp sgt i32 %sub, 0, !store !18
  br i1 %cmp1, label %if.then2, label %if.end, !store !19, !update !20

if.then2:                                         ; preds = %if.then
  %3 = load i32, i32* %x.addr, align 4, !store !21, !undo !22
  store i32 %3, i32* %retval, align 4, !store !23
  br label %return, !store !24

if.end:                                           ; preds = %if.then
  br label %if.end3, !store !25, !undo !26

if.end3:                                          ; preds = %if.end, %entry
  %4 = load i32, i32* %x.addr, align 4, !store !27, !undo !28
  store i32 %4, i32* %retval, align 4, !store !29
  br label %return, !store !24

return:                                           ; preds = %if.end3, %if.then2
  %5 = load i32, i32* %retval, align 4, !store !30
  ret i32 %5, !store !31
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"x <- DiscreteDistribution(supp=2:5)"}
!3 = !{!"y <- DiscreteDistribution(supp=4:7)"}
!4 = !{!"entry <- F; if.then <- F; if.then2 <- F; if.end <- F; if.end3 <- F; return <- F"}
!5 = !{!"p.retval <- alloca(\\\22int\\\22)"}
!6 = !{!"p.x.addr <- alloca(\\\22int\\\22)"}
!7 = !{!"p.y.addr <- alloca(\\\22int\\\22)"}
!8 = !{!"store(x, p.x.addr)"}
!9 = !{!"store(y, p.y.addr)"}
!10 = !{!"v.0 <- load(p.x.addr)"}
!11 = !{!"v.cmp <- icmp(sgt, v.0, 3)"}
!12 = !{!"br(if.then, if.end3, v.cmp)"}
!13 = !{!"{if (!is.numeric(v.0)) v.0 <- add(v.cmp, 3)};store(v.0, p.x.addr); "}
!14 = !{!"v.1 <- load(p.x.addr)"}
!15 = !{!"if(entry) {v.cmp <- v.cmp.true; {if (!is.numeric(v.0)) v.0 <- add(v.cmp, 3)};store(v.0, p.x.addr); };"}
!16 = !{!"v.2 <- load(p.y.addr)"}
!17 = !{!"v.sub <- sub(v.1, v.2)"}
!18 = !{!"v.cmp1 <- icmp(sgt, v.sub, 0)"}
!19 = !{!"br(if.then2, if.end, v.cmp1)"}
!20 = !{!"{if (!is.numeric(v.sub)) v.sub <- add(v.cmp1, 0)};store(v.1, p.x.addr); store(v.2, p.y.addr); "}
!21 = !{!"v.3 <- load(p.x.addr)"}
!22 = !{!"if(if.then) {v.cmp1 <- v.cmp1.true; {if (!is.numeric(v.sub)) v.sub <- add(v.cmp1, 0)};store(v.1, p.x.addr); store(v.2, p.y.addr); };"}
!23 = !{!"store(v.3, p.retval)"}
!24 = !{!"br(return)"}
!25 = !{!"br(if.end3)"}
!26 = !{!"if(if.then) {v.cmp1 <- v.cmp1.false; {if (!is.numeric(v.sub)) v.sub <- add(v.cmp1, 0)};store(v.1, p.x.addr); store(v.2, p.y.addr); };"}
!27 = !{!"v.4 <- load(p.x.addr)"}
!28 = !{!"if(entry) {v.cmp <- v.cmp.false; {if (!is.numeric(v.0)) v.0 <- add(v.cmp, 3)};store(v.0, p.x.addr); };"}
!29 = !{!"store(v.4, p.retval)"}
!30 = !{!"v.5 <- load(p.retval)"}
!31 = !{!"path.return <<- c(path.return, ret(v.5)); return <- T; if.end3 <- F; if.then2 <- F"}
