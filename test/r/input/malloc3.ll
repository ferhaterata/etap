; ModuleID = './.llvm/input.ll'
source_filename = "./input/malloc3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s1 = type { i32 }
%struct.s2 = type { %struct.s1* }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %data = alloca %struct.s1, align 4
  %sp = alloca %struct.s2*, align 8
  %a = alloca [2 x i32], align 4
  store i32 0, i32* %retval, align 4
  %call = call noalias i8* @malloc(i64 8) #2
  %0 = bitcast i8* %call to %struct.s2*
  store %struct.s2* %0, %struct.s2** %sp, align 8
  %1 = load %struct.s2*, %struct.s2** %sp, align 8
  %p = getelementptr inbounds %struct.s2, %struct.s2* %1, i32 0, i32 0
  store %struct.s1* %data, %struct.s1** %p, align 8
  %2 = load %struct.s2*, %struct.s2** %sp, align 8
  %p1 = getelementptr inbounds %struct.s2, %struct.s2* %2, i32 0, i32 0
  %3 = load %struct.s1*, %struct.s1** %p1, align 8
  %d = getelementptr inbounds %struct.s1, %struct.s1* %3, i32 0, i32 0
  store i32 3, i32* %d, align 4
  %d2 = getelementptr inbounds %struct.s1, %struct.s1* %data, i32 0, i32 0
  %4 = load i32, i32* %d2, align 4
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %a, i64 0, i64 1
  store i32 %4, i32* %arrayidx, align 4
  %5 = load %struct.s2*, %struct.s2** %sp, align 8
  %6 = bitcast %struct.s2* %5 to i8*
  call void @free(i8* %6) #2
  %arrayidx3 = getelementptr inbounds [2 x i32], [2 x i32]* %a, i64 0, i64 1
  %7 = load i32, i32* %arrayidx3, align 4
  ret i32 %7
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
