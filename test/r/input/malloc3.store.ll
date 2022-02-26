; ModuleID = 'test/r/input/malloc3.ll'
source_filename = "./input/malloc3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i32 }
%struct.s2 = type { %struct.s1* }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !store !2 {
entry:
  %retval = alloca i32, align 4, !store !3
  %data = alloca %struct.s1, align 4, !store !4
  %sp = alloca %struct.s2*, align 8, !store !5
  %a = alloca [2 x i32], align 4, !store !6
  store i32 0, i32* %retval, align 4, !store !7
  %call = call noalias i8* @malloc(i64 8) #2
  %0 = bitcast i8* %call to %struct.s2*, !store !8
  store %struct.s2* %0, %struct.s2** %sp, align 8, !store !9
  %1 = load %struct.s2*, %struct.s2** %sp, align 8, !store !10
  %p = getelementptr inbounds %struct.s2, %struct.s2* %1, i32 0, i32 0, !store !11
  store %struct.s1* %data, %struct.s1** %p, align 8, !store !12
  %2 = load %struct.s2*, %struct.s2** %sp, align 8, !store !13
  %p1 = getelementptr inbounds %struct.s2, %struct.s2* %2, i32 0, i32 0, !store !14
  %3 = load %struct.s1*, %struct.s1** %p1, align 8, !store !15
  %d = getelementptr inbounds %struct.s1, %struct.s1* %3, i32 0, i32 0, !store !16
  store i32 3, i32* %d, align 4, !store !17
  %d2 = getelementptr inbounds %struct.s1, %struct.s1* %data, i32 0, i32 0, !store !18
  %4 = load i32, i32* %d2, align 4, !store !19
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %a, i64 0, i64 1, !store !20
  store i32 %4, i32* %arrayidx, align 4, !store !21
  %5 = load %struct.s2*, %struct.s2** %sp, align 8, !store !22
  %6 = bitcast %struct.s2* %5 to i8*, !store !23
  call void @free(i8* %6) #2
  %arrayidx3 = getelementptr inbounds [2 x i32], [2 x i32]* %a, i64 0, i64 1, !store !24
  %7 = load i32, i32* %arrayidx3, align 4, !store !25
  ret i32 %7, !store !26
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
!2 = !{!"entry <- F"}
!3 = !{!"p.retval <- alloca(\22int\22)"}
!4 = !{!"p.data <- alloca(\22struct\22)"}
!5 = !{!"p.sp <- alloca(\22struct*\22)"}
!6 = !{!"p.a <- alloca(\22array\22)"}
!7 = !{!"p.retval <- 0"}
!8 = !{!"p.0 <- p.call # BitCast"}
!9 = !{!"p.sp <- p.0"}
!10 = !{!"p.1 <- p.sp"}
!11 = !{!"p.p <- p.1[0]"}
!12 = !{!"p.1[0] <- p.data"}
!13 = !{!"p.2 <- p.sp"}
!14 = !{!"p.p1 <- p.2[0]"}
!15 = !{!"p.3 <- p.2[0]"}
!16 = !{!"p.d <- p.3[0]"}
!17 = !{!"p.3[0] <- 3"}
!18 = !{!"p.d2 <- p.data[0]"}
!19 = !{!"v.4 <- p.data[0]"}
!20 = !{!"p.arrayidx <- p.a[1]"}
!21 = !{!"p.a[1] <- v.4"}
!22 = !{!"p.5 <- p.sp"}
!23 = !{!"p.6 <- p.5 # BitCast"}
!24 = !{!"p.arrayidx3 <- p.a[1]"}
!25 = !{!"v.7 <- p.a[1]"}
!26 = !{!"v..ret <- ret(v.7); entry <- T"}
