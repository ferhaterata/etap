; ModuleID = './.llvm/input.ll'
source_filename = "./input/malloc4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S = type { [2 x i32] }

@buf = dso_local global %struct.S { [2 x i32] [i32 0, i32 1] }, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %q = alloca i32*, align 8
  %p = alloca %struct.S*, align 8
  store i32 0, i32* %retval, align 4
  store i32 3, i32* %i, align 4
  store i32* null, i32** %q, align 8
  %0 = load i32, i32* getelementptr inbounds (%struct.S, %struct.S* @buf, i32 0, i32 0, i64 1), align 4
  %cmp = icmp eq i32 %0, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32* %i, i32** %q, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  store %struct.S* @buf, %struct.S** %p, align 8
  %1 = load %struct.S*, %struct.S** %p, align 8
  %data = getelementptr inbounds %struct.S, %struct.S* %1, i32 0, i32 0
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %data, i64 0, i64 1
  %2 = load i32, i32* %arrayidx, align 4
  %cmp1 = icmp eq i32 %2, 1
  br i1 %cmp1, label %if.then2, label %if.end5

if.then2:                                         ; preds = %if.end
  %3 = load i32*, i32** %q, align 8
  %4 = load i32, i32* %3, align 4
  %5 = load %struct.S*, %struct.S** %p, align 8
  %data3 = getelementptr inbounds %struct.S, %struct.S* %5, i32 0, i32 0
  %arrayidx4 = getelementptr inbounds [2 x i32], [2 x i32]* %data3, i64 0, i64 0
  store i32 %4, i32* %arrayidx4, align 4
  br label %if.end5

if.end5:                                          ; preds = %if.then2, %if.end
  ret i32 0
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
