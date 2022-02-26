; ModuleID = 'test/r/input/conditional3.ll'
source_filename = "./input/conditional3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @checkpoint() #0 !timing !2 !energy !3 !intermittent !4 !intermittent !5 !store !6 {
entry:
  ret void, !store !7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @read(i32* %__pin) #0 !timing !8 !energy !9 !distribution !10 !store !6 !formal !11 {
entry:
  %__pin.addr = alloca i32*, align 8, !store !12
  store i32* %__pin, i32** %__pin.addr, align 8, !store !13
  %0 = load i32*, i32** %__pin.addr, align 8, !store !14
  %1 = load i32, i32* %0, align 4, !store !15
  ret i32 %1, !store !16
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @write(i32* noalias %__out) #0 !timing !8 !energy !17 !store !6 !formal !18 {
entry:
  %__out.addr = alloca i32*, align 8, !store !19
  store i32* %__out, i32** %__out.addr, align 8, !store !20
  ret i32 1, !store !21
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @conditional3(i32 %n) #0 !distribution !22 !store !23 !formal !24 {
entry:
  %retval = alloca i32, align 4, !store !25
  %n.addr = alloca i32, align 4, !store !26
  %pin = alloca i32*, align 8, !distribution !27, !store !28
  %x = alloca i32, align 4, !store !29
  %xp = alloca i32*, align 8, !store !30
  store i32 %n, i32* %n.addr, align 4, !store !31
  store i32* null, i32** %pin, align 8, !store !32
  %0 = load i32*, i32** %pin, align 8, !store !33
  %call = call i32 @read(i32* %0)
  %1 = load i32, i32* %n.addr, align 4, !store !34
  store i32 %1, i32* %x, align 4, !store !35
  store i32* %x, i32** %xp, align 8, !store !36
  call void @checkpoint(), !store !37
  %2 = load i32, i32* %n.addr, align 4, !store !38
  %cmp = icmp sgt i32 %2, 1, !store !39
  br i1 %cmp, label %if.then, label %if.end3, !store !40, !update !41

if.then:                                          ; preds = %entry
  %3 = load i32, i32* %n.addr, align 4, !store !42, !undo !43
  %cmp1 = icmp sgt i32 %3, 2, !store !44
  br i1 %cmp1, label %if.then2, label %if.end, !store !45, !update !46

if.then2:                                         ; preds = %if.then
  %4 = load i32, i32* %n.addr, align 4, !store !47, !undo !48
  store i32 %4, i32* %retval, align 4, !store !49
  br label %return, !store !50

if.end:                                           ; preds = %if.then
  br label %if.end3, !store !51, !undo !52

if.end3:                                          ; preds = %if.end, %entry
  call void @checkpoint(), !store !37, !undo !53
  %5 = load i32*, i32** %xp, align 8, !store !54
  %6 = load i32, i32* %5, align 4, !store !55
  store i32 %6, i32* %retval, align 4, !store !56
  br label %return, !store !50

return:                                           ; preds = %if.end3, %if.then2
  %7 = load i32, i32* %retval, align 4, !store !57
  ret i32 %7, !store !58
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"45"}
!3 = !{!"DiscreteDistribution(5)"}
!4 = !{!"Intermittent Capacitor 100,2000"}
!5 = !{!"Intermittent Checkpoint"}
!6 = !{!"entry <- FALSE"}
!7 = !{!"ret(\\\22void\\\22); entry <- TRUE"}
!8 = !{!"Norm(mean=15,sd=3)"}
!9 = !{!"25"}
!10 = !{!"__pin <- memory(DiscreteDistribution(1:10))"}
!11 = !{!"sym$\\\22__pin\\\22 <- memory(DiscreteDistribution(1:10))"}
!12 = !{!"sym$\\\22__pin.addr\\\22 <- alloca(\\\22i32*\\\22)"}
!13 = !{!"store(sym$\\\22__pin\\\22, sym$\\\22__pin.addr\\\22)"}
!14 = !{!"sym$\\\220\\\22 <- load(sym$\\\22__pin.addr\\\22)"}
!15 = !{!"sym$\\\221\\\22 <- load(sym$\\\220\\\22)"}
!16 = !{!"path.return <<- c(path.return, ret(sym$\\\221\\\22)); entry <- TRUE"}
!17 = !{!"Norm(mean=25,sd=5)"}
!18 = !{!"sym$\\\22__out\\\22 <- galloc(\\\22i32\\\22, 0)"}
!19 = !{!"sym$\\\22__out.addr\\\22 <- alloca(\\\22i32*\\\22)"}
!20 = !{!"store(sym$\\\22__out\\\22, sym$\\\22__out.addr\\\22)"}
!21 = !{!"path.return <<- c(path.return, ret(1)); entry <- TRUE"}
!22 = !{!"n <- DiscreteDistribution(supp=1:4)"}
!23 = !{!"entry <- FALSE; if.then <- FALSE; if.then2 <- FALSE; if.end <- FALSE; if.end3 <- FALSE; return <- FALSE"}
!24 = !{!"sym$\\\22n\\\22 <- DiscreteDistribution(supp=1:4)"}
!25 = !{!"sym$\\\22retval\\\22 <- alloca(\\\22i32\\\22)"}
!26 = !{!"sym$\\\22n.addr\\\22 <- alloca(\\\22i32\\\22)"}
!27 = !{!"pin <- DiscreteDistribution(1:5)"}
!28 = !{!"sym$\\\22pin\\\22 <- alloca(\\\22i32*\\\22)"}
!29 = !{!"sym$\\\22x\\\22 <- alloca(\\\22i32\\\22)"}
!30 = !{!"sym$\\\22xp\\\22 <- alloca(\\\22i32*\\\22)"}
!31 = !{!"store(sym$\\\22n\\\22, sym$\\\22n.addr\\\22)"}
!32 = !{!"store(null, sym$\\\22pin\\\22)"}
!33 = !{!"sym$\\\220\\\22 <- load(sym$\\\22pin\\\22)"}
!34 = !{!"sym$\\\221\\\22 <- load(sym$\\\22n.addr\\\22)"}
!35 = !{!"store(sym$\\\221\\\22, sym$\\\22x\\\22)"}
!36 = !{!"store(sym$\\\22x\\\22, sym$\\\22xp\\\22)"}
!37 = !{!"checkpoint()"}
!38 = !{!"sym$\\\222\\\22 <- load(sym$\\\22n.addr\\\22)"}
!39 = !{!"sym$\\\22cmp\\\22 <- icmp(sgt, sym$\\\222\\\22, 1)"}
!40 = !{!"br(if.then, if.end3, sym$\\\22cmp\\\22)"}
!41 = !{!"{if (!is.numeric(sym$\\\222\\\22)) sym$\\\222\\\22 <- add(sym$\\\22cmp\\\22, 1)};store(sym$\\\222\\\22, sym$\\\22n.addr\\\22); "}
!42 = !{!"sym$\\\223\\\22 <- load(sym$\\\22n.addr\\\22)"}
!43 = !{!"if(entry) {sym$\\\22cmp\\\22 <- sym$\\\22cmp.true\\\22; {if (!is.numeric(sym$\\\222\\\22)) sym$\\\222\\\22 <- add(sym$\\\22cmp\\\22, 1)};store(sym$\\\222\\\22, sym$\\\22n.addr\\\22); };"}
!44 = !{!"sym$\\\22cmp1\\\22 <- icmp(sgt, sym$\\\223\\\22, 2)"}
!45 = !{!"br(if.then2, if.end, sym$\\\22cmp1\\\22)"}
!46 = !{!"{if (!is.numeric(sym$\\\223\\\22)) sym$\\\223\\\22 <- add(sym$\\\22cmp1\\\22, 2)};store(sym$\\\223\\\22, sym$\\\22n.addr\\\22); "}
!47 = !{!"sym$\\\224\\\22 <- load(sym$\\\22n.addr\\\22)"}
!48 = !{!"if(if.then) {sym$\\\22cmp1\\\22 <- sym$\\\22cmp1.true\\\22; {if (!is.numeric(sym$\\\223\\\22)) sym$\\\223\\\22 <- add(sym$\\\22cmp1\\\22, 2)};store(sym$\\\223\\\22, sym$\\\22n.addr\\\22); };"}
!49 = !{!"store(sym$\\\224\\\22, sym$\\\22retval\\\22)"}
!50 = !{!"br(return)"}
!51 = !{!"br(if.end3)"}
!52 = !{!"if(if.then) {sym$\\\22cmp1\\\22 <- sym$\\\22cmp1.false\\\22; {if (!is.numeric(sym$\\\223\\\22)) sym$\\\223\\\22 <- add(sym$\\\22cmp1\\\22, 2)};store(sym$\\\223\\\22, sym$\\\22n.addr\\\22); };"}
!53 = !{!"if(entry) {sym$\\\22cmp\\\22 <- sym$\\\22cmp.false\\\22; {if (!is.numeric(sym$\\\222\\\22)) sym$\\\222\\\22 <- add(sym$\\\22cmp\\\22, 1)};store(sym$\\\222\\\22, sym$\\\22n.addr\\\22); };"}
!54 = !{!"sym$\\\225\\\22 <- load(sym$\\\22xp\\\22)"}
!55 = !{!"sym$\\\226\\\22 <- load(sym$\\\225\\\22)"}
!56 = !{!"store(sym$\\\226\\\22, sym$\\\22retval\\\22)"}
!57 = !{!"sym$\\\227\\\22 <- load(sym$\\\22retval\\\22)"}
!58 = !{!"path.return <<- c(path.return, ret(sym$\\\227\\\22)); return <- TRUE; if.end3 <- FALSE; if.then2 <- FALSE"}
