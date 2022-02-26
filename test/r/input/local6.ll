; ModuleID = './.llvm/input.ll'
source_filename = "./input/local6.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Foo = type { i32, i32, %struct.Bar }
%struct.Bar = type { i32, i32 }

@__const.main.foo = private unnamed_addr constant %struct.Foo { i32 0, i32 1, %struct.Bar { i32 5, i32 3 } }, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %b = alloca i32, align 4
  %a = alloca i32*, align 8
  %foo = alloca %struct.Foo, align 4
  store i32 0, i32* %retval, align 4
  store i32 5, i32* %b, align 4
  store i32* %b, i32** %a, align 8
  %0 = bitcast %struct.Foo* %foo to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %0, i8* align 4 bitcast (%struct.Foo* @__const.main.foo to i8*), i64 16, i1 false)
  %1 = load i32*, i32** %a, align 8
  %2 = load i32, i32* %1, align 4
  %a1 = getelementptr inbounds %struct.Foo, %struct.Foo* %foo, i32 0, i32 0
  store i32 %2, i32* %a1, align 4
  %bar = getelementptr inbounds %struct.Foo, %struct.Foo* %foo, i32 0, i32 2
  %c = getelementptr inbounds %struct.Bar, %struct.Bar* %bar, i32 0, i32 0
  %3 = load i32, i32* %c, align 4
  ret i32 %3
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
