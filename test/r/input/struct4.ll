; ModuleID = './.llvm/input.ll'
source_filename = "./input/struct4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._str = type { i32, i32* }

@s = dso_local global [2 x %struct._str] zeroinitializer, align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 3, i32* getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 0), align 16
  %0 = load i32, i32* getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 0), align 16
  %conv = sext i32 %0 to i64
  %mul = mul i64 4, %conv
  %call = call noalias i8* @malloc(i64 %mul) #2
  %1 = bitcast i8* %call to i32*
  store i32* %1, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8
  %2 = load i32*, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8
  %arrayidx = getelementptr inbounds i32, i32* %2, i64 0
  store i32 2, i32* %arrayidx, align 4
  %3 = load i32*, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8
  %arrayidx1 = getelementptr inbounds i32, i32* %3, i64 1
  store i32 5, i32* %arrayidx1, align 4
  %4 = load i32*, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8
  %arrayidx2 = getelementptr inbounds i32, i32* %4, i64 2
  store i32 7, i32* %arrayidx2, align 4
  %5 = load i32*, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8
  %arrayidx3 = getelementptr inbounds i32, i32* %5, i64 1
  %6 = load i32, i32* %arrayidx3, align 4
  %7 = load i32*, i32** getelementptr inbounds ([2 x %struct._str], [2 x %struct._str]* @s, i64 0, i64 0, i32 1), align 8
  %arrayidx4 = getelementptr inbounds i32, i32* %7, i64 2
  %8 = load i32, i32* %arrayidx4, align 4
  %add = add nsw i32 %6, %8
  store i32 %add, i32* %x, align 4
  %9 = load i32, i32* %x, align 4
  ret i32 %9
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
