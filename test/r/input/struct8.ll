; ModuleID = './.llvm/input.ll'
source_filename = "./input/struct8.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ST = type { %struct.RT, i32, %struct.RT }
%struct.RT = type { i32, [3 x [2 x i32]], i32 }

@st = dso_local global [2 x %struct.ST] zeroinitializer, align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.ST*, align 8
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 2, i32* getelementptr inbounds ([2 x %struct.ST], [2 x %struct.ST]* @st, i64 0, i64 1, i32 2, i32 1, i64 2, i64 1), align 4
  store %struct.ST* getelementptr inbounds ([2 x %struct.ST], [2 x %struct.ST]* @st, i64 0, i64 1), %struct.ST** %s, align 8
  %0 = load %struct.ST*, %struct.ST** %s, align 8
  %Z = getelementptr inbounds %struct.ST, %struct.ST* %0, i32 0, i32 2
  %B = getelementptr inbounds %struct.RT, %struct.RT* %Z, i32 0, i32 1
  %arrayidx = getelementptr inbounds [3 x [2 x i32]], [3 x [2 x i32]]* %B, i64 0, i64 2
  %arrayidx1 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx, i64 0, i64 1
  %1 = load i32, i32* %arrayidx1, align 4
  store i32 %1, i32* %i, align 4
  %2 = load i32, i32* %i, align 4
  ret i32 %2
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
