; ModuleID = 'test/r/input/struct8.ll'
source_filename = "./input/struct8.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ST = type { %struct.RT, i32, %struct.RT }
%struct.RT = type { i32, [3 x [2 x i32]], i32 }

@st = dso_local global [2 x %struct.ST] zeroinitializer, align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !store !2 {
entry:
  %retval = alloca i32, align 4, !store !3
  %s = alloca %struct.ST*, align 8, !store !4
  %i = alloca i32, align 4, !store !5
  store i32 0, i32* %retval, align 4, !store !6
  store i32 2, i32* getelementptr inbounds ([2 x %struct.ST], [2 x %struct.ST]* @st, i64 0, i64 1, i32 2, i32 1, i64 2, i64 1), align 4, !store !7
  store %struct.ST* getelementptr inbounds ([2 x %struct.ST], [2 x %struct.ST]* @st, i64 0, i64 1), %struct.ST** %s, align 8, !store !8
  %0 = load %struct.ST*, %struct.ST** %s, align 8, !store !9
  %Z = getelementptr inbounds %struct.ST, %struct.ST* %0, i32 0, i32 2, !store !10
  %B = getelementptr inbounds %struct.RT, %struct.RT* %Z, i32 0, i32 1, !store !11
  %arrayidx = getelementptr inbounds [3 x [2 x i32]], [3 x [2 x i32]]* %B, i64 0, i64 2, !store !12
  %arrayidx1 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx, i64 0, i64 1, !store !13
  %1 = load i32, i32* %arrayidx1, align 4, !store !14
  store i32 %1, i32* %i, align 4, !store !15
  %2 = load i32, i32* %i, align 4, !store !16
  ret i32 %2, !store !17
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"entry <- FALSE"}
!3 = !{!"sym$\\\22%retval\\\22 <- alloca(\\\22i32\\\22)"}
!4 = !{!"sym$\\\22%s\\\22 <- alloca(\\\22%struct.ST*\\\22)"}
!5 = !{!"sym$\\\22%i\\\22 <- alloca(\\\22i32\\\22)"}
!6 = !{!"store(0, sym$\\\22%retval\\\22)"}
!7 = !{!"store(2, gep(\\\22[2 x %struct.ST]\\\22, sym$\\\22@st\\\22, 0, 1, 2, 1, 2, 1))"}
!8 = !{!"store(gep(\\\22[2 x %struct.ST]\\\22, sym$\\\22@st\\\22, 0, 1), sym$\\\22%s\\\22)"}
!9 = !{!"sym$\\\22%0\\\22 <- load(sym$\\\22%s\\\22)"}
!10 = !{!"sym$\\\22%Z\\\22 <- gep(\\\22%struct.ST\\\22, sym$\\\22%0\\\22, 0, 2)"}
!11 = !{!"sym$\\\22%B\\\22 <- gep(\\\22%struct.RT\\\22, sym$\\\22%Z\\\22, 0, 1)"}
!12 = !{!"sym$\\\22%arrayidx\\\22 <- gep(\\\22[3 x [2 x i32]]\\\22, sym$\\\22%B\\\22, 0, 2)"}
!13 = !{!"sym$\\\22%arrayidx1\\\22 <- gep(\\\22[2 x i32]\\\22, sym$\\\22%arrayidx\\\22, 0, 1)"}
!14 = !{!"sym$\\\22%1\\\22 <- load(sym$\\\22%arrayidx1\\\22)"}
!15 = !{!"store(sym$\\\22%1\\\22, sym$\\\22%i\\\22)"}
!16 = !{!"sym$\\\22%2\\\22 <- load(sym$\\\22%i\\\22)"}
!17 = !{!"path.return <<- c(path.return, ret(sym$\\\22%2\\\22)); entry <- TRUE"}
