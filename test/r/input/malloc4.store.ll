; ModuleID = 'test/r/input/malloc4.ll'
source_filename = "./input/malloc4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S = type { [2 x i32] }

@buf = dso_local global %struct.S { [2 x i32] [i32 0, i32 1] }, align 4, !global !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !store !3 {
entry:
  %retval = alloca i32, align 4, !store !4
  %i = alloca i32, align 4, !store !5
  %q = alloca i32*, align 8, !store !6
  %p = alloca %struct.S*, align 8, !store !7
  store i32 0, i32* %retval, align 4, !store !8
  store i32 3, i32* %i, align 4, !store !9
  store i32* null, i32** %q, align 8, !store !10
  %0 = load i32, i32* getelementptr inbounds (%struct.S, %struct.S* @buf, i32 0, i32 0, i64 1), align 4, !store !11
  %cmp = icmp eq i32 %0, 1, !store !12
  br i1 %cmp, label %if.then, label %if.end, !store !13

if.then:                                          ; preds = %entry
  store i32* %i, i32** %q, align 8, !store !14
  br label %if.end, !store !15

if.end:                                           ; preds = %if.then, %entry
  store %struct.S* @buf, %struct.S** %p, align 8, !store !16
  %1 = load %struct.S*, %struct.S** %p, align 8, !store !17
  %data = getelementptr inbounds %struct.S, %struct.S* %1, i32 0, i32 0, !store !18
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %data, i64 0, i64 1, !store !19
  %2 = load i32, i32* %arrayidx, align 4, !store !20
  %cmp1 = icmp eq i32 %2, 1, !store !21
  br i1 %cmp1, label %if.then2, label %if.end5, !store !22

if.then2:                                         ; preds = %if.end
  %3 = load i32*, i32** %q, align 8, !store !23
  %4 = load i32, i32* %3, align 4, !store !24
  %5 = load %struct.S*, %struct.S** %p, align 8, !store !25
  %data3 = getelementptr inbounds %struct.S, %struct.S* %5, i32 0, i32 0, !store !26
  %arrayidx4 = getelementptr inbounds [2 x i32], [2 x i32]* %data3, i64 0, i64 0, !store !27
  store i32 %4, i32* %arrayidx4, align 4, !store !28
  br label %if.end5, !store !29

if.end5:                                          ; preds = %if.then2, %if.end
  ret i32 0, !store !30
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!1}
!llvm.ident = !{!2}

!0 = !{!"c.buf <- env(\\\220\\\22 = list(\\\220\\\22 = 0, \\\221\\\22 = 1))"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!3 = !{!"entry <- F; if.then <- F; if.end <- F; if.then2 <- F; if.end5 <- F"}
!4 = !{!"p.retval <- alloca(\22int\22)"}
!5 = !{!"p.i <- alloca(\22int\22)"}
!6 = !{!"p.q <- alloca(\22int*\22)"}
!7 = !{!"p.p <- alloca(\22struct*\22)"}
!8 = !{!"store(0, p.retval)"}
!9 = !{!"store(3, p.i)"}
!10 = !{!"store(null, p.q)"}
!11 = !{!"v.0 <- load(gep(ptr(c.buf), 0))"}
!12 = !{!"v.cmp <- v.0 - 1; if (is.numeric(v.cmp)) v.cmp <- DiscreteDistribution(v.cmp); v.cmp <- p(v.cmp)(0) - p(v.cmp)(-1)"}
!13 = !{!"%entry%if.then <- round(v.cmp, 2); %entry%if.end <- round(1 - v.cmp, 2); entry <- T"}
!14 = !{!"store(p.i, p.q)"}
!15 = !{!"%if.then%if.end <- 1.00; if.then <- T; entry <- F"}
!16 = !{!"store(c.buf, p.p)"}
!17 = !{!"p.1 <- load(p.p)"}
!18 = !{!"p.data <- gep(p.1, 0)"}
!19 = !{!"p.arrayidx <- gep(p.data, 1)"}
!20 = !{!"v.2 <- load(p.arrayidx)"}
!21 = !{!"v.cmp1 <- v.2 - 1; if (is.numeric(v.cmp1)) v.cmp1 <- DiscreteDistribution(v.cmp1); v.cmp1 <- p(v.cmp1)(0) - p(v.cmp1)(-1)"}
!22 = !{!"%if.end%if.then2 <- round(v.cmp1, 2); %if.end%if.end5 <- round(1 - v.cmp1, 2); if.end <- T; if.then <- F; entry <- F"}
!23 = !{!"p.3 <- load(p.q)"}
!24 = !{!"v.4 <- load(p.3)"}
!25 = !{!"p.5 <- load(p.p)"}
!26 = !{!"p.data3 <- gep(p.5, 0)"}
!27 = !{!"p.arrayidx4 <- gep(p.data3, 0)"}
!28 = !{!"store(v.4, p.arrayidx4)"}
!29 = !{!"%if.then2%if.end5 <- 1.00; if.then2 <- T; if.end <- F"}
!30 = !{!".ret <- ret(0); if.end5 <- T; if.then2 <- F; if.end <- F"}
