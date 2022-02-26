; ModuleID = 'test/r/input/malloc2.ll'
source_filename = "./input/malloc2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !store !2 {
entry:
  %retval = alloca i32, align 4, !store !3
  %i = alloca i32*, align 8, !store !4
  %ret = alloca i32, align 4, !store !5
  store i32 0, i32* %retval, align 4, !store !6
  %call = call noalias i8* @malloc(i64 20) #2, !store !7
  %0 = bitcast i8* %call to i32*, !store !8
  store i32* %0, i32** %i, align 8, !store !9
  %1 = load i32*, i32** %i, align 8, !store !10
  store i32 12, i32* %1, align 4, !store !11
  %2 = load i32*, i32** %i, align 8, !store !12
  %add.ptr = getelementptr inbounds i32, i32* %2, i64 1, !store !13
  store i32 24, i32* %add.ptr, align 4, !store !14
  %3 = load i32*, i32** %i, align 8, !store !15
  %arrayidx = getelementptr inbounds i32, i32* %3, i64 1, !store !16
  %4 = load i32, i32* %arrayidx, align 4, !store !17
  store i32 %4, i32* %ret, align 4, !store !18
  %5 = load i32*, i32** %i, align 8, !store !19
  %6 = bitcast i32* %5 to i8*, !store !20
  call void @free(i8* %6) #2
  %7 = load i32, i32* %ret, align 4, !store !21
  ret i32 %7, !store !22
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"entry <- FALSE"}
!3 = !{!"sym$\\\22%retval\\\22 <- alloca(\\\22i32\\\22)"}
!4 = !{!"sym$\\\22%i\\\22 <- alloca(\\\22i32*\\\22)"}
!5 = !{!"sym$\\\22%ret\\\22 <- alloca(\\\22i32\\\22)"}
!6 = !{!"store(0, sym$\\\22%retval\\\22)"}
!7 = !{!"sym$\\\22%call\\\22 <- malloc(20)"}
!8 = !{!"sym$\\\22%0\\\22 <- bitcast(\\\22i8*\\\22, sym$\\\22%call\\\22, \\\22i32*\\\22)"}
!9 = !{!"store(sym$\\\22%0\\\22, sym$\\\22%i\\\22)"}
!10 = !{!"sym$\\\22%1\\\22 <- load(sym$\\\22%i\\\22)"}
!11 = !{!"store(12, sym$\\\22%1\\\22)"}
!12 = !{!"sym$\\\22%2\\\22 <- load(sym$\\\22%i\\\22)"}
!13 = !{!"sym$\\\22%add.ptr\\\22 <- gep(\\\22i32\\\22, sym$\\\22%2\\\22, 1)"}
!14 = !{!"store(24, sym$\\\22%add.ptr\\\22)"}
!15 = !{!"sym$\\\22%3\\\22 <- load(sym$\\\22%i\\\22)"}
!16 = !{!"sym$\\\22%arrayidx\\\22 <- gep(\\\22i32\\\22, sym$\\\22%3\\\22, 1)"}
!17 = !{!"sym$\\\22%4\\\22 <- load(sym$\\\22%arrayidx\\\22)"}
!18 = !{!"store(sym$\\\22%4\\\22, sym$\\\22%ret\\\22)"}
!19 = !{!"sym$\\\22%5\\\22 <- load(sym$\\\22%i\\\22)"}
!20 = !{!"sym$\\\22%6\\\22 <- bitcast(\\\22i32*\\\22, sym$\\\22%5\\\22, \\\22i8*\\\22)"}
!21 = !{!"sym$\\\22%7\\\22 <- load(sym$\\\22%ret\\\22)"}
!22 = !{!"path.return <<- c(path.return, ret(sym$\\\22%7\\\22)); entry <- TRUE"}
