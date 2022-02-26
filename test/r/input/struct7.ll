; ModuleID = './.llvm/input.ll'
source_filename = "./input/struct7.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S = type { [2 x i32] }

@buf = dso_local global %struct.S { [2 x i32] [i32 0, i32 1] }, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %p = alloca %struct.s*, align 8
  store i32 0, i32* %retval, align 4
  store %struct.S* @buf, %struct.S** %p, align 8
  store i32 3, i32* getelementptr inbounds (%struct.S, %struct.S* @buf, i32 0, i32 0, i64 1), align 4
  %0 = load %struct.S*, %struct.S** %p, align 8
  %data = getelementptr inbounds %struct.S, %struct.S* %0, i32 0, i32 0
  %arraydecay = getelementptr inbounds [2 x i32], [2 x i32]* %data, i64 0, i64 0
  %add.ptr = getelementptr inbounds i32, i32* %arraydecay, i64 1
  %1 = load i32, i32* %add.ptr, align 4
  ret i32 %1
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
