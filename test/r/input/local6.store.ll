; ModuleID = 'test/r/input/local6.ll'
source_filename = "./input/local6.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Foo = type { i32, i32, %struct.Bar }
%struct.Bar = type { i32, i32 }

@__const.main.foo = private unnamed_addr constant %struct.Foo { i32 0, i32 1, %struct.Bar { i32 5, i32 3 } }, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !store !2 {
entry:
  %retval = alloca i32, align 4, !store !3
  %b = alloca i32, align 4, !store !4
  %a = alloca i32*, align 8, !store !5
  %foo = alloca %struct.Foo, align 4, !store !6
  store i32 0, i32* %retval, align 4, !store !7
  store i32 5, i32* %b, align 4, !store !8
  store i32* %b, i32** %a, align 8, !store !9
  %0 = bitcast %struct.Foo* %foo to i8*, !store !10
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %0, i8* align 4 bitcast (%struct.Foo* @__const.main.foo to i8*), i64 16, i1 false), !store !11
  %1 = load i32*, i32** %a, align 8, !store !12
  %2 = load i32, i32* %1, align 4, !store !13
  %a1 = getelementptr inbounds %struct.Foo, %struct.Foo* %foo, i32 0, i32 0, !store !14
  store i32 %2, i32* %a1, align 4, !store !15
  %bar = getelementptr inbounds %struct.Foo, %struct.Foo* %foo, i32 0, i32 2, !store !16
  %c = getelementptr inbounds %struct.Bar, %struct.Bar* %bar, i32 0, i32 0, !store !17
  %3 = load i32, i32* %c, align 4, !store !18
  ret i32 %3, !store !19
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"entry <- FALSE"}
!3 = !{!"sym$\\\22retval\\\22 <- alloca(\\\22i32\\\22)"}
!4 = !{!"sym$\\\22b\\\22 <- alloca(\\\22i32\\\22)"}
!5 = !{!"sym$\\\22a\\\22 <- alloca(\\\22i32*\\\22)"}
!6 = !{!"sym$\\\22foo\\\22 <- alloca(\\\22%struct.Foo\\\22)"}
!7 = !{!"store(0, sym$\\\22retval\\\22)"}
!8 = !{!"store(5, sym$\\\22b\\\22)"}
!9 = !{!"store(sym$\\\22b\\\22, sym$\\\22a\\\22)"}
!10 = !{!"sym$\\\220\\\22 <- bitcast(\\\22%struct.Foo*\\\22, sym$\\\22foo\\\22, \\\22i8*\\\22)"}
!11 = !{!"memcpy(sym$\\\220\\\22, sym$\\\22__const.main.foo\\\22, \\\22%struct.Foo*\\\22)"}
!12 = !{!"sym$\\\221\\\22 <- load(sym$\\\22a\\\22)"}
!13 = !{!"sym$\\\222\\\22 <- load(sym$\\\221\\\22)"}
!14 = !{!"sym$\\\22a1\\\22 <- gep(\\\22%struct.Foo\\\22, sym$\\\22foo\\\22, 0, 0)"}
!15 = !{!"store(sym$\\\222\\\22, sym$\\\22a1\\\22)"}
!16 = !{!"sym$\\\22bar\\\22 <- gep(\\\22%struct.Foo\\\22, sym$\\\22foo\\\22, 0, 2)"}
!17 = !{!"sym$\\\22c\\\22 <- gep(\\\22%struct.Bar\\\22, sym$\\\22bar\\\22, 0, 0)"}
!18 = !{!"sym$\\\223\\\22 <- load(sym$\\\22c\\\22)"}
!19 = !{!"path.return <<- c(path.return, ret(sym$\\\223\\\22)); entry <- TRUE"}
