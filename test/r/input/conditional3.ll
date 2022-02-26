; ModuleID = './.llvm/input.ll'
source_filename = "./input/conditional3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @checkpoint() #0 !timing !2 !energy !3 !intermittent !4 !intermittent !5 {
entry:
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @read(i32* %__pin) #0 !timing !6 !energy !7 !distribution !8 {
entry:
  %__pin.addr = alloca i32*, align 8
  store i32* %__pin, i32** %__pin.addr, align 8
  %0 = load i32*, i32** %__pin.addr, align 8
  %1 = load i32, i32* %0, align 4
  ret i32 %1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @write(i32* noalias %__out) #0 !timing !6 !energy !9 {
entry:
  %__out.addr = alloca i32*, align 8
  store i32* %__out, i32** %__out.addr, align 8
  ret i32 1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @conditional3(i32 %n) #0 !distribution !10 {
entry:
  %retval = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %pin = alloca i32*, align 8, !distribution !11
  %x = alloca i32, align 4
  %xp = alloca i32*, align 8
  store i32 %n, i32* %n.addr, align 4
  store i32* null, i32** %pin, align 8
  %0 = load i32*, i32** %pin, align 8
  %call = call i32 @read(i32* %0)
  %1 = load i32, i32* %n.addr, align 4
  store i32 %1, i32* %x, align 4
  store i32* %x, i32** %xp, align 8
  call void @checkpoint()
  %2 = load i32, i32* %n.addr, align 4
  %cmp = icmp sgt i32 %2, 1
  br i1 %cmp, label %if.then, label %if.end3

if.then:                                          ; preds = %entry
  %3 = load i32, i32* %n.addr, align 4
  %cmp1 = icmp sgt i32 %3, 2
  br i1 %cmp1, label %if.then2, label %if.end

if.then2:                                         ; preds = %if.then
  %4 = load i32, i32* %n.addr, align 4
  store i32 %4, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.then
  br label %if.end3

if.end3:                                          ; preds = %if.end, %entry
  call void @checkpoint()
  %5 = load i32*, i32** %xp, align 8
  %6 = load i32, i32* %5, align 4
  store i32 %6, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end3, %if.then2
  %7 = load i32, i32* %retval, align 4
  ret i32 %7
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
!6 = !{!"Norm(mean=15,sd=3)"}
!7 = !{!"25"}
!8 = !{!"__pin <- memory(DiscreteDistribution(1:10))"}
!9 = !{!"Norm(mean=25,sd=5)"}
!10 = !{!"n <- DiscreteDistribution(supp=1:4)"}
!11 = !{!"pin <- DiscreteDistribution(1:5)"}
