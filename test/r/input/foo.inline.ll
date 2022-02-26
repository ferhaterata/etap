; ModuleID = './.llvm/inst-conf.ll'
source_filename = "./input/foo.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: alwaysinline nounwind uwtable
define dso_local double @foo(double %x, double %y) #0 !dbg !7 !distribution !12 !distribution !13 !reliability !14 !reliability !15 {
entry:
  call void @llvm.dbg.value(metadata double %x, metadata !16, metadata !DIExpression()), !dbg !17, !cost !18
  call void @llvm.dbg.value(metadata double %y, metadata !19, metadata !DIExpression()), !dbg !17, !cost !18
  %add = fadd double %y, 6.000000e+00, !dbg !20, !cost !18
  %cmp = fcmp olt double %x, %add, !dbg !22, !cost !18
  br i1 %cmp, label %if.then, label %if.end4, !dbg !23, !cost !18, !block !24

if.then:                                          ; preds = %entry
  %mul = fmul double 2.000000e+00, %y, !dbg !25, !cost !18
  call void @llvm.dbg.value(metadata double %mul, metadata !27, metadata !DIExpression()), !dbg !28, !cost !18
  %cmp1 = fcmp ogt double %mul, -2.000000e+00, !dbg !29, !cost !18
  br i1 %cmp1, label %if.then2, label %if.end, !dbg !31, !cost !18, !block !32

if.then2:                                         ; preds = %if.then
  %mul3 = fmul double %x, %y, !dbg !33, !cost !18
  br label %return, !dbg !34, !cost !18, !block !35

if.end:                                           ; preds = %if.then
  br label %if.end4, !dbg !36, !cost !18, !block !37

if.end4:                                          ; preds = %if.end, %entry
  br label %return, !dbg !38, !cost !18, !block !37

return:                                           ; preds = %if.end4, %if.then2
  %retval.0 = phi double [ %mul3, %if.then2 ], [ %x, %if.end4 ], !dbg !17, !cost !18
  ret double %retval.0, !dbg !39, !cost !18, !block !35
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @bar(i32 %x, i32 %y) #2 !dbg !40 !distribution !44 !distribution !45 !reliability !46 !reliability !47 {
entry:
  %retval = alloca i32, align 4, !cost !48
  %x.addr = alloca i32, align 4, !cost !48
  %y.addr = alloca i32, align 4, !cost !48
  %a = alloca i32, align 4, !cost !48
  store i32 %x, i32* %x.addr, align 4, !cost !18
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !49, metadata !DIExpression()), !dbg !50, !cost !18
  store i32 %y, i32* %y.addr, align 4, !cost !18
  call void @llvm.dbg.declare(metadata i32* %y.addr, metadata !51, metadata !DIExpression()), !dbg !52, !cost !18
  %0 = load i32, i32* %x.addr, align 4, !dbg !53, !cost !55
  %1 = load i32, i32* %y.addr, align 4, !dbg !56, !cost !55
  %add = add nsw i32 %1, 6, !dbg !57, !cost !18
  %cmp = icmp slt i32 %0, %add, !dbg !58, !cost !18
  br i1 %cmp, label %if.then, label %if.end4, !dbg !59, !cost !18, !block !60

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %a, metadata !61, metadata !DIExpression()), !dbg !63, !cost !18
  %2 = load i32, i32* %y.addr, align 4, !dbg !64, !cost !55
  %mul = mul nsw i32 2, %2, !dbg !65, !cost !18
  store i32 %mul, i32* %a, align 4, !dbg !63, !cost !18
  %3 = load i32, i32* %a, align 4, !dbg !66, !cost !55
  %cmp1 = icmp sge i32 %3, 8, !dbg !68, !cost !18
  br i1 %cmp1, label %if.then2, label %if.end, !dbg !69, !cost !18, !block !70

if.then2:                                         ; preds = %if.then
  %4 = load i32, i32* %x.addr, align 4, !dbg !71, !cost !55
  %5 = load i32, i32* %y.addr, align 4, !dbg !72, !cost !55
  %mul3 = mul nsw i32 %4, %5, !dbg !73, !cost !18
  store i32 %mul3, i32* %retval, align 4, !dbg !74, !cost !18
  br label %return, !dbg !74, !cost !18, !block !75

if.end:                                           ; preds = %if.then
  br label %if.end4, !dbg !76, !cost !18, !block !37

if.end4:                                          ; preds = %if.end, %entry
  %6 = load i32, i32* %x.addr, align 4, !dbg !77, !cost !55
  store i32 %6, i32* %retval, align 4, !dbg !78, !cost !18
  br label %return, !dbg !78, !cost !18, !block !79

return:                                           ; preds = %if.end4, %if.then2
  %7 = load i32, i32* %retval, align 4, !dbg !80, !cost !55
  ret i32 %7, !dbg !80, !cost !18, !block !81
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @baz(double %x, double %y) #2 !dbg !82 !distribution !12 !distribution !13 !reliability !83 !reliability !84 {
entry:
  %retval.i = alloca double, align 8, !cost !48
  %x.addr.i = alloca double, align 8, !cost !48
  %y.addr.i = alloca double, align 8, !cost !48
  %a.i = alloca double, align 8, !cost !48
  %x.addr = alloca double, align 8, !cost !48
  %y.addr = alloca double, align 8, !cost !48
  %z = alloca double, align 8, !cost !48
  %i = alloca i32, align 4, !cost !48
  store double %x, double* %x.addr, align 8, !cost !18
  call void @llvm.dbg.declare(metadata double* %x.addr, metadata !85, metadata !DIExpression()), !dbg !86, !cost !18
  store double %y, double* %y.addr, align 8, !cost !18
  call void @llvm.dbg.declare(metadata double* %y.addr, metadata !87, metadata !DIExpression()), !dbg !88, !cost !18
  call void @llvm.dbg.declare(metadata double* %z, metadata !89, metadata !DIExpression()), !dbg !90, !cost !18
  store double 0.000000e+00, double* %z, align 8, !dbg !90, !cost !18
  call void @llvm.dbg.declare(metadata i32* %i, metadata !91, metadata !DIExpression()), !dbg !93, !cost !18
  store i32 1, i32* %i, align 4, !dbg !93, !cost !18
  br label %for.cond, !dbg !94, !cost !18, !block !95

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !96, !cost !55
  %cmp = icmp slt i32 %0, 3, !dbg !98, !cost !18
  br i1 %cmp, label %for.body, label %for.end, !dbg !99, !cost !18, !block !79

for.body:                                         ; preds = %for.cond
  %1 = load double, double* %x.addr, align 8, !dbg !100, !cost !55
  %2 = load double, double* %y.addr, align 8, !dbg !102, !cost !55
  store double %1, double* %x.addr.i, align 8, !cost !18
  call void @llvm.dbg.declare(metadata double* %x.addr.i, metadata !16, metadata !DIExpression()), !dbg !103, !cost !18
  store double %2, double* %y.addr.i, align 8, !cost !18
  call void @llvm.dbg.declare(metadata double* %y.addr.i, metadata !19, metadata !DIExpression()), !dbg !105, !cost !18
  %3 = load double, double* %x.addr.i, align 8, !dbg !106, !cost !55
  %4 = load double, double* %y.addr.i, align 8, !dbg !107, !cost !55
  %add.i = fadd double %4, 6.000000e+00, !dbg !108, !cost !18
  %cmp.i = fcmp olt double %3, %add.i, !dbg !109, !cost !18
  br i1 %cmp.i, label %if.then.i, label %if.end4.i, !dbg !110, !cost !18, !block !111

if.then.i:                                        ; preds = %for.body
  call void @llvm.dbg.declare(metadata double* %a.i, metadata !27, metadata !DIExpression()), !dbg !112, !cost !18
  %5 = load double, double* %y.addr.i, align 8, !dbg !113, !cost !55
  %mul.i = fmul double 2.000000e+00, %5, !dbg !114, !cost !18
  store double %mul.i, double* %a.i, align 8, !dbg !112, !cost !18
  %6 = load double, double* %a.i, align 8, !dbg !115, !cost !55
  %cmp1.i = fcmp ogt double %6, -2.000000e+00, !dbg !116, !cost !18
  br i1 %cmp1.i, label %if.then2.i, label %if.end.i, !dbg !117, !cost !18, !block !70

if.then2.i:                                       ; preds = %if.then.i
  %7 = load double, double* %x.addr.i, align 8, !dbg !118, !cost !55
  %8 = load double, double* %y.addr.i, align 8, !dbg !119, !cost !55
  %mul3.i = fmul double %7, %8, !dbg !120, !cost !18
  store double %mul3.i, double* %retval.i, align 8, !dbg !121, !cost !18
  br label %foo.exit, !dbg !121, !cost !18, !block !75

if.end.i:                                         ; preds = %if.then.i
  br label %if.end4.i, !dbg !122, !cost !18, !block !37

if.end4.i:                                        ; preds = %if.end.i, %for.body
  %9 = load double, double* %x.addr.i, align 8, !dbg !123, !cost !55
  store double %9, double* %retval.i, align 8, !dbg !124, !cost !18
  br label %foo.exit, !dbg !124, !cost !18, !block !79

foo.exit:                                         ; preds = %if.end4.i, %if.then2.i
  %10 = load double, double* %retval.i, align 8, !dbg !125, !cost !55
  %11 = load double, double* %z, align 8, !dbg !126, !cost !55
  %add = fadd double %11, %10, !dbg !126, !cost !18
  store double %add, double* %z, align 8, !dbg !126, !cost !18
  br label %for.inc, !dbg !127, !cost !18, !block !75

for.inc:                                          ; preds = %foo.exit
  %12 = load i32, i32* %i, align 4, !dbg !128, !cost !55
  %inc = add nsw i32 %12, 1, !dbg !128, !cost !18
  store i32 %inc, i32* %i, align 4, !dbg !128, !cost !18
  br label %for.cond, !dbg !129, !llvm.loop !130, !cost !18, !block !132

for.end:                                          ; preds = %for.cond
  %13 = load double, double* %z, align 8, !dbg !133, !cost !55
  ret double %13, !dbg !134, !cost !18, !block !81
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @sum(i32 %x) #2 !dbg !135 !distribution !138 !reliability !139 !reliability !140 {
entry:
  %x.addr = alloca i32, align 4, !cost !48
  %result = alloca i32, align 4, !cost !48
  %i = alloca i32, align 4, !cost !48
  store i32 %x, i32* %x.addr, align 4, !cost !18
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !141, metadata !DIExpression()), !dbg !142, !cost !18
  call void @llvm.dbg.declare(metadata i32* %result, metadata !143, metadata !DIExpression()), !dbg !144, !cost !18
  store i32 1, i32* %result, align 4, !dbg !144, !cost !18
  call void @llvm.dbg.declare(metadata i32* %i, metadata !145, metadata !DIExpression()), !dbg !147, !cost !18
  store i32 0, i32* %i, align 4, !dbg !147, !cost !18
  br label %for.cond, !dbg !148, !cost !18, !block !149

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !150, !cost !55
  %1 = load i32, i32* %x.addr, align 4, !dbg !152, !cost !55
  %cmp = icmp slt i32 %0, %1, !dbg !153, !cost !18
  br i1 %cmp, label %for.body, label %for.end, !dbg !154, !cost !18, !block !155

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %x.addr, align 4, !dbg !156, !cost !55
  %3 = load i32, i32* %i, align 4, !dbg !158, !cost !55
  %add = add nsw i32 %2, %3, !dbg !159, !cost !18
  store i32 %add, i32* %result, align 4, !dbg !160, !cost !18
  br label %for.inc, !dbg !161, !cost !18, !block !75

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4, !dbg !162, !cost !55
  %inc = add nsw i32 %4, 1, !dbg !162, !cost !18
  store i32 %inc, i32* %i, align 4, !dbg !162, !cost !18
  br label %for.cond, !dbg !163, !llvm.loop !164, !cost !18, !block !132

for.end:                                          ; preds = %for.cond
  %5 = load i32, i32* %result, align 4, !dbg !166, !cost !55
  ret i32 %5, !dbg !167, !cost !18, !block !81
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { alwaysinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { noinline nounwind optnone uwtable "correctly-rounded-split-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "input/foo.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"}
!7 = distinct !DISubprogram(name: "foo", scope: !8, file: !8, line: 7, type: !9, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "./input/foo.c", directory: "/home/ferhat/git/analysis-framework-standalone-application")
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !11, !11}
!11 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!12 = !{!"x <- Norm(mean=11, sd=1)"}
!13 = !{!"y <- Norm(mean=5, sd=1)"}
!14 = !{!"timing ;  12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)"}
!15 = !{!"energy ;  DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!16 = !DILocalVariable(name: "x", arg: 1, scope: !7, file: !8, line: 7, type: !11)
!17 = !DILocation(line: 0, scope: !7)
!18 = !{!"timing; 12 * DiscreteDistribution(1);energy; DiscreteDistribution(supp = 12, prob = 1)"}
!19 = !DILocalVariable(name: "y", arg: 2, scope: !7, file: !8, line: 7, type: !11)
!20 = !DILocation(line: 10, column: 13, scope: !21)
!21 = distinct !DILexicalBlock(scope: !7, file: !8, line: 10, column: 7)
!22 = !DILocation(line: 10, column: 9, scope: !21)
!23 = !DILocation(line: 10, column: 7, scope: !7)
!24 = !{!"timing ;  12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!25 = !DILocation(line: 11, column: 18, scope: !26)
!26 = distinct !DILexicalBlock(scope: !21, file: !8, line: 10, column: 18)
!27 = !DILocalVariable(name: "a", scope: !26, file: !8, line: 11, type: !11)
!28 = !DILocation(line: 0, scope: !26)
!29 = !DILocation(line: 12, column: 11, scope: !30)
!30 = distinct !DILexicalBlock(scope: !26, file: !8, line: 12, column: 9)
!31 = !DILocation(line: 12, column: 9, scope: !26)
!32 = !{!"timing ;  12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!33 = !DILocation(line: 12, column: 26, scope: !30)
!34 = !DILocation(line: 12, column: 17, scope: !30)
!35 = !{!"timing ;  12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!36 = !DILocation(line: 13, column: 3, scope: !26)
!37 = !{!"timing ;  12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)"}
!38 = !DILocation(line: 14, column: 3, scope: !7)
!39 = !DILocation(line: 15, column: 1, scope: !7)
!40 = distinct !DISubprogram(name: "bar", scope: !8, file: !8, line: 17, type: !41, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!41 = !DISubroutineType(types: !42)
!42 = !{!43, !43, !43}
!43 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!44 = !{!"x <- DiscreteDistribution(supp = 10:11)"}
!45 = !{!"y <- DiscreteDistribution(supp = 2:7)"}
!46 = !{!"timing ;  10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)"}
!47 = !{!"energy ;  50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)"}
!48 = !{!"timing; 10;energy; 50"}
!49 = !DILocalVariable(name: "x", arg: 1, scope: !40, file: !8, line: 17, type: !43)
!50 = !DILocation(line: 17, column: 13, scope: !40)
!51 = !DILocalVariable(name: "y", arg: 2, scope: !40, file: !8, line: 17, type: !43)
!52 = !DILocation(line: 17, column: 20, scope: !40)
!53 = !DILocation(line: 20, column: 7, scope: !54)
!54 = distinct !DILexicalBlock(scope: !40, file: !8, line: 20, column: 7)
!55 = !{!"timing; 12;energy; 50"}
!56 = !DILocation(line: 20, column: 11, scope: !54)
!57 = !DILocation(line: 20, column: 13, scope: !54)
!58 = !DILocation(line: 20, column: 9, scope: !54)
!59 = !DILocation(line: 20, column: 7, scope: !40)
!60 = !{!"timing ;  10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!61 = !DILocalVariable(name: "a", scope: !62, file: !8, line: 21, type: !43)
!62 = distinct !DILexicalBlock(scope: !54, file: !8, line: 20, column: 18)
!63 = !DILocation(line: 21, column: 9, scope: !62)
!64 = !DILocation(line: 21, column: 17, scope: !62)
!65 = !DILocation(line: 21, column: 15, scope: !62)
!66 = !DILocation(line: 22, column: 9, scope: !67)
!67 = distinct !DILexicalBlock(scope: !62, file: !8, line: 22, column: 9)
!68 = !DILocation(line: 22, column: 11, scope: !67)
!69 = !DILocation(line: 22, column: 9, scope: !62)
!70 = !{!"timing ;  12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!71 = !DILocation(line: 23, column: 14, scope: !67)
!72 = !DILocation(line: 23, column: 18, scope: !67)
!73 = !DILocation(line: 23, column: 16, scope: !67)
!74 = !DILocation(line: 23, column: 7, scope: !67)
!75 = !{!"timing ;  12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!76 = !DILocation(line: 24, column: 3, scope: !62)
!77 = !DILocation(line: 25, column: 10, scope: !40)
!78 = !DILocation(line: 25, column: 3, scope: !40)
!79 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!80 = !DILocation(line: 26, column: 1, scope: !40)
!81 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)"}
!82 = distinct !DISubprogram(name: "baz", scope: !8, file: !8, line: 28, type: !9, scopeLine: 28, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!83 = !{!"timing ;  10+ 10+ 10+ 10+ 10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)"}
!84 = !{!"energy ;  50+ 50+ 50+ 50+ 50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)"}
!85 = !DILocalVariable(name: "x", arg: 1, scope: !82, file: !8, line: 28, type: !11)
!86 = !DILocation(line: 28, column: 19, scope: !82)
!87 = !DILocalVariable(name: "y", arg: 2, scope: !82, file: !8, line: 28, type: !11)
!88 = !DILocation(line: 28, column: 29, scope: !82)
!89 = !DILocalVariable(name: "z", scope: !82, file: !8, line: 31, type: !11)
!90 = !DILocation(line: 31, column: 10, scope: !82)
!91 = !DILocalVariable(name: "i", scope: !92, file: !8, line: 32, type: !43)
!92 = distinct !DILexicalBlock(scope: !82, file: !8, line: 32, column: 3)
!93 = !DILocation(line: 32, column: 12, scope: !92)
!94 = !DILocation(line: 32, column: 8, scope: !92)
!95 = !{!"timing ;  10+ 10+ 10+ 10+ 10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ 50+ 50+ 50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!96 = !DILocation(line: 32, column: 19, scope: !97)
!97 = distinct !DILexicalBlock(scope: !92, file: !8, line: 32, column: 3)
!98 = !DILocation(line: 32, column: 21, scope: !97)
!99 = !DILocation(line: 32, column: 3, scope: !92)
!100 = !DILocation(line: 33, column: 14, scope: !101)
!101 = distinct !DILexicalBlock(scope: !97, file: !8, line: 32, column: 31)
!102 = !DILocation(line: 33, column: 17, scope: !101)
!103 = !DILocation(line: 7, column: 50, scope: !7, inlinedAt: !104)
!104 = distinct !DILocation(line: 33, column: 10, scope: !101)
!105 = !DILocation(line: 7, column: 60, scope: !7, inlinedAt: !104)
!106 = !DILocation(line: 10, column: 7, scope: !21, inlinedAt: !104)
!107 = !DILocation(line: 10, column: 11, scope: !21, inlinedAt: !104)
!108 = !DILocation(line: 10, column: 13, scope: !21, inlinedAt: !104)
!109 = !DILocation(line: 10, column: 9, scope: !21, inlinedAt: !104)
!110 = !DILocation(line: 10, column: 7, scope: !7, inlinedAt: !104)
!111 = !{!"timing ;  12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!112 = !DILocation(line: 11, column: 12, scope: !26, inlinedAt: !104)
!113 = !DILocation(line: 11, column: 20, scope: !26, inlinedAt: !104)
!114 = !DILocation(line: 11, column: 18, scope: !26, inlinedAt: !104)
!115 = !DILocation(line: 12, column: 9, scope: !30, inlinedAt: !104)
!116 = !DILocation(line: 12, column: 11, scope: !30, inlinedAt: !104)
!117 = !DILocation(line: 12, column: 9, scope: !26, inlinedAt: !104)
!118 = !DILocation(line: 12, column: 24, scope: !30, inlinedAt: !104)
!119 = !DILocation(line: 12, column: 28, scope: !30, inlinedAt: !104)
!120 = !DILocation(line: 12, column: 26, scope: !30, inlinedAt: !104)
!121 = !DILocation(line: 12, column: 17, scope: !30, inlinedAt: !104)
!122 = !DILocation(line: 13, column: 3, scope: !26, inlinedAt: !104)
!123 = !DILocation(line: 14, column: 10, scope: !7, inlinedAt: !104)
!124 = !DILocation(line: 14, column: 3, scope: !7, inlinedAt: !104)
!125 = !DILocation(line: 15, column: 1, scope: !7, inlinedAt: !104)
!126 = !DILocation(line: 33, column: 7, scope: !101)
!127 = !DILocation(line: 34, column: 3, scope: !101)
!128 = !DILocation(line: 32, column: 26, scope: !97)
!129 = !DILocation(line: 32, column: 3, scope: !97)
!130 = distinct !{!130, !99, !131}
!131 = !DILocation(line: 34, column: 3, scope: !92)
!132 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!133 = !DILocation(line: 35, column: 10, scope: !82)
!134 = !DILocation(line: 35, column: 3, scope: !82)
!135 = distinct !DISubprogram(name: "sum", scope: !8, file: !8, line: 38, type: !136, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!136 = !DISubroutineType(types: !137)
!137 = !{!43, !43}
!138 = !{!"x <- DiscreteDistribution(supp = 1:5)"}
!139 = !{!"timing ;  10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)"}
!140 = !{!"energy ;  50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)"}
!141 = !DILocalVariable(name: "x", arg: 1, scope: !135, file: !8, line: 38, type: !43)
!142 = !DILocation(line: 38, column: 13, scope: !135)
!143 = !DILocalVariable(name: "result", scope: !135, file: !8, line: 40, type: !43)
!144 = !DILocation(line: 40, column: 7, scope: !135)
!145 = !DILocalVariable(name: "i", scope: !146, file: !8, line: 41, type: !43)
!146 = distinct !DILexicalBlock(scope: !135, file: !8, line: 41, column: 3)
!147 = !DILocation(line: 41, column: 12, scope: !146)
!148 = !DILocation(line: 41, column: 8, scope: !146)
!149 = !{!"timing ;  10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!150 = !DILocation(line: 41, column: 19, scope: !151)
!151 = distinct !DILexicalBlock(scope: !146, file: !8, line: 41, column: 3)
!152 = !DILocation(line: 41, column: 23, scope: !151)
!153 = !DILocation(line: 41, column: 21, scope: !151)
!154 = !DILocation(line: 41, column: 3, scope: !146)
!155 = !{!"timing ;  12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!156 = !DILocation(line: 42, column: 14, scope: !157)
!157 = distinct !DILexicalBlock(scope: !151, file: !8, line: 41, column: 31)
!158 = !DILocation(line: 42, column: 18, scope: !157)
!159 = !DILocation(line: 42, column: 16, scope: !157)
!160 = !DILocation(line: 42, column: 12, scope: !157)
!161 = !DILocation(line: 43, column: 3, scope: !157)
!162 = !DILocation(line: 41, column: 26, scope: !151)
!163 = !DILocation(line: 41, column: 3, scope: !151)
!164 = distinct !{!164, !154, !165}
!165 = !DILocation(line: 43, column: 3, scope: !146)
!166 = !DILocation(line: 44, column: 10, scope: !135)
!167 = !DILocation(line: 44, column: 3, scope: !135)
