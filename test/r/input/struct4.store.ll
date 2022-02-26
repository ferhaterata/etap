; ModuleID = 'test/r/input/struct4.ll'
source_filename = "./input/struct4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._str = type { i32, i32* }

@s = dso_local global [2 x %struct._str] zeroinitializer, align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !store !2 {
entry:
  %retval = alloca i32, align 4, !store !3
  %x = alloca i32, align 4, !store !4
  store i32 0, i32* %retval, align 4, !store !5
  store i32 3, i32* getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 0), align 16, !store !6
  %0 = load i32, i32* getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 0), align 16, !store !7
  %conv = sext i32 %0 to i64, !store !8
  %mul = mul i64 4, %conv, !store !9
  %call = call noalias i8* @malloc(i64 %mul) #2, !store !10
  %1 = bitcast i8* %call to i32*, !store !11
  store i32* %1, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8, !store !12
  %2 = load i32*, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8, !store !13
  %arrayidx = getelementptr inbounds i32, i32* %2, i64 0, !store !14
  store i32 2, i32* %arrayidx, align 4, !store !15
  %3 = load i32*, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8, !store !16
  %arrayidx1 = getelementptr inbounds i32, i32* %3, i64 1, !store !17
  store i32 5, i32* %arrayidx1, align 4, !store !18
  %4 = load i32*, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8, !store !19
  %arrayidx2 = getelementptr inbounds i32, i32* %4, i64 2, !store !20
  store i32 7, i32* %arrayidx2, align 4, !store !21
  %5 = load i32*, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8, !store !22
  %arrayidx3 = getelementptr inbounds i32, i32* %5, i64 1, !store !23
  %6 = load i32, i32* %arrayidx3, align 4, !store !24
  %7 = load i32*, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8, !store !25
  %arrayidx4 = getelementptr inbounds i32, i32* %7, i64 2, !store !26
  %8 = load i32, i32* %arrayidx4, align 4, !store !27
  %add = add nsw i32 %6, %8, !store !28
  store i32 %add, i32* %x, align 4, !store !29
  %9 = load i32, i32* %x, align 4, !store !30
  ret i32 %9, !store !31
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"entry <- FALSE"}
!3 = !{!"sym$\\\22%retval\\\22 <- alloca(\\\22i32\\\22)"}
!4 = !{!"sym$\\\22%x\\\22 <- alloca(\\\22i32\\\22)"}
!5 = !{!"store(0, sym$\\\22%retval\\\22)"}
!6 = !{!"store(3, gep(\\\22[2 x %struct._str]\\\22, sym$\\\22@s\\\22, 0, 0, 0))"}
!7 = !{!"sym$\\\22%0\\\22 <- load(gep(\\\22[2 x %struct._str]\\\22, sym$\\\22@s\\\22, 0, 0, 0))"}
!8 = !{!"sym$\\\22%conv\\\22 <- sext(\\\22i32\\\22, sym$\\\22%0\\\22, \\\22i64\\\22)"}
!9 = !{!"sym$\\\22%mul\\\22 <- mul(4, sym$\\\22%conv\\\22)"}
!10 = !{!"sym$\\\22%call\\\22 <- malloc()"}
!11 = !{!"sym$\\\22%1\\\22 <- bitcast(\\\22i8*\\\22, sym$\\\22%call\\\22, \\\22i32*\\\22)"}
!12 = !{!"store(sym$\\\22%1\\\22, gep(\\\22[2 x %struct._str]\\\22, sym$\\\22@s\\\22, 0, 0, 1))"}
!13 = !{!"sym$\\\22%2\\\22 <- load(gep(\\\22[2 x %struct._str]\\\22, sym$\\\22@s\\\22, 0, 0, 1))"}
!14 = !{!"sym$\\\22%arrayidx\\\22 <- gep(\\\22i32\\\22, sym$\\\22%2\\\22, 0)"}
!15 = !{!"store(2, sym$\\\22%arrayidx\\\22)"}
!16 = !{!"sym$\\\22%3\\\22 <- load(gep(\\\22[2 x %struct._str]\\\22, sym$\\\22@s\\\22, 0, 0, 1))"}
!17 = !{!"sym$\\\22%arrayidx1\\\22 <- gep(\\\22i32\\\22, sym$\\\22%3\\\22, 1)"}
!18 = !{!"store(5, sym$\\\22%arrayidx1\\\22)"}
!19 = !{!"sym$\\\22%4\\\22 <- load(gep(\\\22[2 x %struct._str]\\\22, sym$\\\22@s\\\22, 0, 0, 1))"}
!20 = !{!"sym$\\\22%arrayidx2\\\22 <- gep(\\\22i32\\\22, sym$\\\22%4\\\22, 2)"}
!21 = !{!"store(7, sym$\\\22%arrayidx2\\\22)"}
!22 = !{!"sym$\\\22%5\\\22 <- load(gep(\\\22[2 x %struct._str]\\\22, sym$\\\22@s\\\22, 0, 0, 1))"}
!23 = !{!"sym$\\\22%arrayidx3\\\22 <- gep(\\\22i32\\\22, sym$\\\22%5\\\22, 1)"}
!24 = !{!"sym$\\\22%6\\\22 <- load(sym$\\\22%arrayidx3\\\22)"}
!25 = !{!"sym$\\\22%7\\\22 <- load(gep(\\\22[2 x %struct._str]\\\22, sym$\\\22@s\\\22, 0, 0, 1))"}
!26 = !{!"sym$\\\22%arrayidx4\\\22 <- gep(\\\22i32\\\22, sym$\\\22%7\\\22, 2)"}
!27 = !{!"sym$\\\22%8\\\22 <- load(sym$\\\22%arrayidx4\\\22)"}
!28 = !{!"sym$\\\22%add\\\22 <- add(sym$\\\22%6\\\22, sym$\\\22%8\\\22)"}
!29 = !{!"store(sym$\\\22%add\\\22, sym$\\\22%x\\\22)"}
!30 = !{!"sym$\\\22%9\\\22 <- load(sym$\\\22%x\\\22)"}
!31 = !{!"path.return <<- c(path.return, ret(sym$\\\22%9\\\22)); entry <- TRUE"}
