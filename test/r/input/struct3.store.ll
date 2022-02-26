; ModuleID = 'test/r/input/struct3.ll'
source_filename = "./input/struct3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Foo = type { i32, i32, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @index_i(i32 %i) #0 !store !2 !formal !3 {
entry:
  %i.addr = alloca i32, align 4, !store !4
  %foo = alloca [3 x %struct.Foo], align 16, !store !5
  store i32 %i, i32* %i.addr, align 4, !store !6
  %0 = load i32, i32* %i.addr, align 4, !store !7
  %idxprom = sext i32 %0 to i64, !store !8
  %arrayidx = getelementptr inbounds [3 x %struct.Foo], [3 x %struct.Foo]* %foo, i64 0, i64 %idxprom, !store !9
  %b = getelementptr inbounds %struct.Foo, %struct.Foo* %arrayidx, i32 0, i32 1, !store !10
  store i32 4, i32* %b, align 4, !store !11
  %1 = load i32, i32* %i.addr, align 4, !store !12
  %idxprom1 = sext i32 %1 to i64, !store !13
  %arrayidx2 = getelementptr inbounds [3 x %struct.Foo], [3 x %struct.Foo]* %foo, i64 0, i64 %idxprom1, !store !14
  %b3 = getelementptr inbounds %struct.Foo, %struct.Foo* %arrayidx2, i32 0, i32 1, !store !15
  %2 = load i32, i32* %b3, align 4, !store !16
  ret i32 %2, !store !17
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!2 = !{!"entry <- F"}
!3 = !{!"i <- DiscreteDistribution(0)"}
!4 = !{!"p.i.addr <- alloca(\22int\22)"}
!5 = !{!"p.foo <- alloca(\22array\22)"}
!6 = !{!"store(i, p.i.addr)"}
!7 = !{!"v.0 <- load(p.i.addr)"}
!8 = !{!"v.idxprom <- sext(v.0)"}
!9 = !{!"p.arrayidx <- gep(p.foo, 0, v.idxprom)"}
!10 = !{!"p.b <- gep(p.arrayidx, 0, 1)"}
!11 = !{!"store(4, p.b)"}
!12 = !{!"v.1 <- load(p.i.addr)"}
!13 = !{!"v.idxprom1 <- sext(v.1)"}
!14 = !{!"p.arrayidx2 <- gep(p.foo, 0, v.idxprom1)"}
!15 = !{!"p.b3 <- gep(p.arrayidx2, 0, 1)"}
!16 = !{!"v.2 <- load(p.b3)"}
!17 = !{!".ret <- ret(v.2); entry <- T"}
