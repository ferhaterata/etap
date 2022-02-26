; ModuleID = 'test/r/input/foo.inline.store.ll'
source_filename = "./input/foo.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: alwaysinline nounwind uwtable
define dso_local double @foo(double %x, double %y) #0 !dbg !7 !distribution !12 !distribution !13 !reliability !14 !reliability !15 !store !16 !formal !17 !formal !18 {
entry:
  call void @llvm.dbg.value(metadata double %x, metadata !19, metadata !DIExpression()), !dbg !20, !cost !21
  call void @llvm.dbg.value(metadata double %y, metadata !22, metadata !DIExpression()), !dbg !20, !cost !21
  %add = fadd double %y, 6.000000e+00, !dbg !23, !store !25, !cost !21
  %cmp = fcmp olt double %x, %add, !dbg !26, !store !27, !cost !21
  br i1 %cmp, label %if.then, label %if.end4, !dbg !28, !store !29, !cost !21, !block !30

if.then:                                          ; preds = %entry
  %mul = fmul double 2.000000e+00, %y, !dbg !31, !store !33, !cost !21
  call void @llvm.dbg.value(metadata double %mul, metadata !34, metadata !DIExpression()), !dbg !35, !cost !21
  %cmp1 = fcmp ogt double %mul, -2.000000e+00, !dbg !36, !store !38, !cost !21
  br i1 %cmp1, label %if.then2, label %if.end, !dbg !39, !store !40, !cost !21, !block !41

if.then2:                                         ; preds = %if.then
  %mul3 = fmul double %x, %y, !dbg !42, !store !43, !cost !21
  br label %return, !dbg !44, !store !45, !cost !21, !block !46

if.end:                                           ; preds = %if.then
  br label %if.end4, !dbg !47, !store !48, !cost !21, !block !49

if.end4:                                          ; preds = %if.end, %entry
  br label %return, !dbg !50, !store !51, !cost !21, !block !49

return:                                           ; preds = %if.end4, %if.then2
  %retval.0 = phi double [ %mul3, %if.then2 ], [ %x, %if.end4 ], !dbg !20, !store !52, !cost !21
  ret double %retval.0, !dbg !53, !store !54, !cost !21, !block !46
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @bar(i32 %x, i32 %y) #2 !dbg !55 !distribution !59 !distribution !60 !reliability !61 !reliability !62 !store !16 !formal !63 !formal !64 {
entry:
  %retval = alloca i32, align 4, !store !65, !cost !66
  %x.addr = alloca i32, align 4, !store !67, !cost !66
  %y.addr = alloca i32, align 4, !store !68, !cost !66
  %a = alloca i32, align 4, !store !69, !cost !66
  store i32 %x, i32* %x.addr, align 4, !store !70, !cost !21
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !71, metadata !DIExpression()), !dbg !72, !cost !21
  store i32 %y, i32* %y.addr, align 4, !store !73, !cost !21
  call void @llvm.dbg.declare(metadata i32* %y.addr, metadata !74, metadata !DIExpression()), !dbg !75, !cost !21
  %0 = load i32, i32* %x.addr, align 4, !dbg !76, !store !78, !cost !79
  %1 = load i32, i32* %y.addr, align 4, !dbg !80, !store !81, !cost !79
  %add = add nsw i32 %1, 6, !dbg !82, !store !83, !cost !21
  %cmp = icmp slt i32 %0, %add, !dbg !84, !store !85, !cost !21
  br i1 %cmp, label %if.then, label %if.end4, !dbg !86, !store !29, !cost !21, !block !87

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %a, metadata !88, metadata !DIExpression()), !dbg !90, !cost !21
  %2 = load i32, i32* %y.addr, align 4, !dbg !91, !store !92, !cost !79
  %mul = mul nsw i32 2, %2, !dbg !93, !store !94, !cost !21
  store i32 %mul, i32* %a, align 4, !dbg !90, !store !95, !cost !21
  %3 = load i32, i32* %a, align 4, !dbg !96, !store !98, !cost !79
  %cmp1 = icmp sge i32 %3, 8, !dbg !99, !store !100, !cost !21
  br i1 %cmp1, label %if.then2, label %if.end, !dbg !101, !store !40, !cost !21, !block !102

if.then2:                                         ; preds = %if.then
  %4 = load i32, i32* %x.addr, align 4, !dbg !103, !store !104, !cost !79
  %5 = load i32, i32* %y.addr, align 4, !dbg !105, !store !106, !cost !79
  %mul3 = mul nsw i32 %4, %5, !dbg !107, !store !108, !cost !21
  store i32 %mul3, i32* %retval, align 4, !dbg !109, !store !110, !cost !21
  br label %return, !dbg !109, !store !45, !cost !21, !block !111

if.end:                                           ; preds = %if.then
  br label %if.end4, !dbg !112, !store !48, !cost !21, !block !49

if.end4:                                          ; preds = %if.end, %entry
  %6 = load i32, i32* %x.addr, align 4, !dbg !113, !store !114, !cost !79
  store i32 %6, i32* %retval, align 4, !dbg !115, !store !116, !cost !21
  br label %return, !dbg !115, !store !51, !cost !21, !block !117

return:                                           ; preds = %if.end4, %if.then2
  %7 = load i32, i32* %retval, align 4, !dbg !118, !store !119, !cost !79
  ret i32 %7, !dbg !118, !store !120, !cost !21, !block !121
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @baz(double %x, double %y) #2 !dbg !122 !distribution !12 !distribution !13 !reliability !123 !reliability !124 !store !125 !formal !17 !formal !18 {
entry:
  %retval.i = alloca double, align 8, !store !126, !cost !66
  %x.addr.i = alloca double, align 8, !store !127, !cost !66
  %y.addr.i = alloca double, align 8, !store !128, !cost !66
  %a.i = alloca double, align 8, !store !129, !cost !66
  %x.addr = alloca double, align 8, !store !130, !cost !66
  %y.addr = alloca double, align 8, !store !131, !cost !66
  %z = alloca double, align 8, !store !132, !cost !66
  %i = alloca i32, align 4, !store !133, !cost !66
  store double %x, double* %x.addr, align 8, !store !70, !cost !21
  call void @llvm.dbg.declare(metadata double* %x.addr, metadata !134, metadata !DIExpression()), !dbg !135, !cost !21
  store double %y, double* %y.addr, align 8, !store !73, !cost !21
  call void @llvm.dbg.declare(metadata double* %y.addr, metadata !136, metadata !DIExpression()), !dbg !137, !cost !21
  call void @llvm.dbg.declare(metadata double* %z, metadata !138, metadata !DIExpression()), !dbg !139, !cost !21
  store double 0.000000e+00, double* %z, align 8, !dbg !139, !store !132, !cost !21
  call void @llvm.dbg.declare(metadata i32* %i, metadata !140, metadata !DIExpression()), !dbg !142, !cost !21
  store i32 1, i32* %i, align 4, !dbg !142, !store !143, !cost !21
  br label %for.cond, !dbg !144, !store !145, !cost !21, !block !146

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !147, !store !149, !cost !79
  %cmp = icmp slt i32 %0, 3, !dbg !150, !store !151, !cost !21
  br i1 %cmp, label %for.body, label %for.end, !dbg !152, !store !153, !cost !21, !block !117

for.body:                                         ; preds = %for.cond
  %1 = load double, double* %x.addr, align 8, !dbg !154, !store !156, !cost !79
  %2 = load double, double* %y.addr, align 8, !dbg !157, !store !92, !cost !79
  store double %1, double* %x.addr.i, align 8, !store !158, !cost !21
  call void @llvm.dbg.declare(metadata double* %x.addr.i, metadata !19, metadata !DIExpression()), !dbg !159, !cost !21
  store double %2, double* %y.addr.i, align 8, !store !161, !cost !21
  call void @llvm.dbg.declare(metadata double* %y.addr.i, metadata !22, metadata !DIExpression()), !dbg !162, !cost !21
  %3 = load double, double* %x.addr.i, align 8, !dbg !163, !store !164, !cost !79
  %4 = load double, double* %y.addr.i, align 8, !dbg !165, !store !166, !cost !79
  %add.i = fadd double %4, 6.000000e+00, !dbg !167, !store !168, !cost !21
  %cmp.i = fcmp olt double %3, %add.i, !dbg !169, !store !170, !cost !21
  br i1 %cmp.i, label %if.then.i, label %if.end4.i, !dbg !171, !store !172, !cost !21, !block !173

if.then.i:                                        ; preds = %for.body
  call void @llvm.dbg.declare(metadata double* %a.i, metadata !34, metadata !DIExpression()), !dbg !174, !cost !21
  %5 = load double, double* %y.addr.i, align 8, !dbg !175, !store !176, !cost !79
  %mul.i = fmul double 2.000000e+00, %5, !dbg !177, !store !178, !cost !21
  store double %mul.i, double* %a.i, align 8, !dbg !174, !store !179, !cost !21
  %6 = load double, double* %a.i, align 8, !dbg !180, !store !181, !cost !79
  %cmp1.i = fcmp ogt double %6, -2.000000e+00, !dbg !182, !store !183, !cost !21
  br i1 %cmp1.i, label %if.then2.i, label %if.end.i, !dbg !184, !store !185, !cost !21, !block !102

if.then2.i:                                       ; preds = %if.then.i
  %7 = load double, double* %x.addr.i, align 8, !dbg !186, !store !187, !cost !79
  %8 = load double, double* %y.addr.i, align 8, !dbg !188, !store !189, !cost !79
  %mul3.i = fmul double %7, %8, !dbg !190, !store !191, !cost !21
  store double %mul3.i, double* %retval.i, align 8, !dbg !192, !store !193, !cost !21
  br label %foo.exit, !dbg !192, !store !194, !cost !21, !block !111

if.end.i:                                         ; preds = %if.then.i
  br label %if.end4.i, !dbg !195, !store !196, !cost !21, !block !49

if.end4.i:                                        ; preds = %if.end.i, %for.body
  %9 = load double, double* %x.addr.i, align 8, !dbg !197, !store !198, !cost !79
  store double %9, double* %retval.i, align 8, !dbg !199, !store !200, !cost !21
  br label %foo.exit, !dbg !199, !store !201, !cost !21, !block !117

foo.exit:                                         ; preds = %if.end4.i, %if.then2.i
  %10 = load double, double* %retval.i, align 8, !dbg !202, !store !203, !cost !79
  %11 = load double, double* %z, align 8, !dbg !204, !store !205, !cost !79
  %add = fadd double %11, %10, !dbg !204, !store !206, !cost !21
  store double %add, double* %z, align 8, !dbg !204, !store !207, !cost !21
  br label %for.inc, !dbg !208, !store !209, !cost !21, !block !111

for.inc:                                          ; preds = %foo.exit
  %12 = load i32, i32* %i, align 4, !dbg !210, !store !211, !cost !79
  %inc = add nsw i32 %12, 1, !dbg !210, !store !212, !cost !21
  store i32 %inc, i32* %i, align 4, !dbg !210, !store !213, !cost !21
  br label %for.cond, !dbg !214, !llvm.loop !215, !store !217, !cost !21, !block !218

for.end:                                          ; preds = %for.cond
  %13 = load double, double* %z, align 8, !dbg !219, !store !220, !cost !79
  ret double %13, !dbg !221, !store !222, !cost !21, !block !121
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @factorial(i32 %x) #2 !dbg !223 !distribution !226 !reliability !227 !reliability !228 !store !229 !formal !230 {
entry:
  %x.addr = alloca i32, align 4, !store !67, !cost !66
  %result = alloca i32, align 4, !store !231, !cost !66
  %i = alloca i32, align 4, !store !133, !cost !66
  store i32 %x, i32* %x.addr, align 4, !store !70, !cost !21
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !232, metadata !DIExpression()), !dbg !233, !cost !21
  call void @llvm.dbg.declare(metadata i32* %result, metadata !234, metadata !DIExpression()), !dbg !235, !cost !21
  store i32 1, i32* %result, align 4, !dbg !235, !store !236, !cost !21
  call void @llvm.dbg.declare(metadata i32* %i, metadata !237, metadata !DIExpression()), !dbg !239, !cost !21
  store i32 0, i32* %i, align 4, !dbg !239, !store !133, !cost !21
  br label %for.cond, !dbg !240, !store !145, !cost !21, !block !241

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !242, !store !149, !cost !79
  %1 = load i32, i32* %x.addr, align 4, !dbg !244, !store !156, !cost !79
  %cmp = icmp slt i32 %0, %1, !dbg !245, !store !246, !cost !21
  br i1 %cmp, label %for.body, label %for.end, !dbg !247, !store !153, !cost !21, !block !248

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %result, align 4, !dbg !249, !store !251, !cost !79
  %inc = add nsw i32 %2, 1, !dbg !249, !store !252, !cost !21
  store i32 %inc, i32* %result, align 4, !dbg !249, !store !253, !cost !21
  br label %for.inc, !dbg !254, !store !255, !cost !21, !block !218

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4, !dbg !256, !store !257, !cost !79
  %inc1 = add nsw i32 %3, 1, !dbg !256, !store !258, !cost !21
  store i32 %inc1, i32* %i, align 4, !dbg !256, !store !259, !cost !21
  br label %for.cond, !dbg !260, !llvm.loop !261, !store !263, !cost !21, !block !218

for.end:                                          ; preds = %for.cond
  %4 = load i32, i32* %result, align 4, !dbg !264, !store !265, !cost !79
  ret i32 %4, !dbg !266, !store !267, !cost !21, !block !121
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
!16 = !{!"entry <- F; if.then <- F; if.then2 <- F; if.end <- F; if.end4 <- F; return <- F"}
!17 = !{!"%x <- Norm(mean=11, sd=1)"}
!18 = !{!"%y <- Norm(mean=5, sd=1)"}
!19 = !DILocalVariable(name: "x", arg: 1, scope: !7, file: !8, line: 7, type: !11)
!20 = !DILocation(line: 0, scope: !7)
!21 = !{!"timing; 12 * DiscreteDistribution(1);energy; DiscreteDistribution(supp = 12, prob = 1)"}
!22 = !DILocalVariable(name: "y", arg: 2, scope: !7, file: !8, line: 7, type: !11)
!23 = !DILocation(line: 10, column: 13, scope: !24)
!24 = distinct !DILexicalBlock(scope: !7, file: !8, line: 10, column: 7)
!25 = !{!"%add <- %y + 6.000000e+00"}
!26 = !DILocation(line: 10, column: 9, scope: !24)
!27 = !{!"%cmp <- %x - %add; if (is.numeric(%cmp)) %cmp <- DiscreteDistribution(%cmp); %cmp <- p(%cmp)(-0.01)"}
!28 = !DILocation(line: 10, column: 7, scope: !7)
!29 = !{!"%entry%if.then <- round(%cmp, 2); %entry%if.end4 <- round(1 - %cmp, 2); entry <- T"}
!30 = !{!"timing ;  12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!31 = !DILocation(line: 11, column: 18, scope: !32)
!32 = distinct !DILexicalBlock(scope: !24, file: !8, line: 10, column: 18)
!33 = !{!"%mul <- 2.000000e+00 * %y"}
!34 = !DILocalVariable(name: "a", scope: !32, file: !8, line: 11, type: !11)
!35 = !DILocation(line: 0, scope: !32)
!36 = !DILocation(line: 12, column: 11, scope: !37)
!37 = distinct !DILexicalBlock(scope: !32, file: !8, line: 12, column: 9)
!38 = !{!"%cmp1 <- %mul - -2.000000e+00; if (is.numeric(%cmp1)) %cmp1 <- DiscreteDistribution(%cmp1); %cmp1 <- 1 - p(%cmp1)(0.01)"}
!39 = !DILocation(line: 12, column: 9, scope: !32)
!40 = !{!"%if.then%if.then2 <- round(%cmp1, 2); %if.then%if.end <- round(1 - %cmp1, 2); if.then <- T; entry <- F"}
!41 = !{!"timing ;  12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!42 = !DILocation(line: 12, column: 26, scope: !37)
!43 = !{!"%mul3 <- %x * %y"}
!44 = !DILocation(line: 12, column: 17, scope: !37)
!45 = !{!"%if.then2%return <- 1.00; if.then2 <- T; if.then <- F"}
!46 = !{!"timing ;  12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!47 = !DILocation(line: 13, column: 3, scope: !32)
!48 = !{!"%if.end%if.end4 <- 1.00; if.end <- T; if.then <- F"}
!49 = !{!"timing ;  12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)"}
!50 = !DILocation(line: 14, column: 3, scope: !7)
!51 = !{!"%if.end4%return <- 1.00; if.end4 <- T; if.end <- F; entry <- F"}
!52 = !{!"%retval.0 <- if (if.then2) %mul3 else if (if.end4) %x"}
!53 = !DILocation(line: 15, column: 1, scope: !7)
!54 = !{!"%ret <- %retval.0; return <- T; if.end4 <- F; if.then2 <- F"}
!55 = distinct !DISubprogram(name: "bar", scope: !8, file: !8, line: 17, type: !56, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!56 = !DISubroutineType(types: !57)
!57 = !{!58, !58, !58}
!58 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!59 = !{!"x <- DiscreteDistribution(supp = 10:11)"}
!60 = !{!"y <- DiscreteDistribution(supp = 2:7)"}
!61 = !{!"timing ;  10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)"}
!62 = !{!"energy ;  50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)"}
!63 = !{!"%x <- DiscreteDistribution(supp = 10:11)"}
!64 = !{!"%y <- DiscreteDistribution(supp = 2:7)"}
!65 = !{!"%retval <- 0"}
!66 = !{!"timing; 10;energy; 50"}
!67 = !{!"%x.addr <- 0"}
!68 = !{!"%y.addr <- 0"}
!69 = !{!"%a <- 0"}
!70 = !{!"%x.addr <- %x"}
!71 = !DILocalVariable(name: "x", arg: 1, scope: !55, file: !8, line: 17, type: !58)
!72 = !DILocation(line: 17, column: 13, scope: !55)
!73 = !{!"%y.addr <- %y"}
!74 = !DILocalVariable(name: "y", arg: 2, scope: !55, file: !8, line: 17, type: !58)
!75 = !DILocation(line: 17, column: 20, scope: !55)
!76 = !DILocation(line: 20, column: 7, scope: !77)
!77 = distinct !DILexicalBlock(scope: !55, file: !8, line: 20, column: 7)
!78 = !{!"%0 <- %x.addr"}
!79 = !{!"timing; 12;energy; 50"}
!80 = !DILocation(line: 20, column: 11, scope: !77)
!81 = !{!"%1 <- %y.addr"}
!82 = !DILocation(line: 20, column: 13, scope: !77)
!83 = !{!"%add <- %1 + 6"}
!84 = !DILocation(line: 20, column: 9, scope: !77)
!85 = !{!"%cmp <- %0 - %add; if (is.numeric(%cmp)) %cmp <- DiscreteDistribution(%cmp); %cmp <- p(%cmp)(-1)"}
!86 = !DILocation(line: 20, column: 7, scope: !55)
!87 = !{!"timing ;  10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!88 = !DILocalVariable(name: "a", scope: !89, file: !8, line: 21, type: !58)
!89 = distinct !DILexicalBlock(scope: !77, file: !8, line: 20, column: 18)
!90 = !DILocation(line: 21, column: 9, scope: !89)
!91 = !DILocation(line: 21, column: 17, scope: !89)
!92 = !{!"%2 <- %y.addr"}
!93 = !DILocation(line: 21, column: 15, scope: !89)
!94 = !{!"%mul <- 2 * %2"}
!95 = !{!"%a <- %mul"}
!96 = !DILocation(line: 22, column: 9, scope: !97)
!97 = distinct !DILexicalBlock(scope: !89, file: !8, line: 22, column: 9)
!98 = !{!"%3 <- %a"}
!99 = !DILocation(line: 22, column: 11, scope: !97)
!100 = !{!"%cmp1 <- %3 - 8; if (is.numeric(%cmp1)) %cmp1 <- DiscreteDistribution(%cmp1); %cmp1 <- 1 - p(%cmp1)(0)"}
!101 = !DILocation(line: 22, column: 9, scope: !89)
!102 = !{!"timing ;  12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!103 = !DILocation(line: 23, column: 14, scope: !97)
!104 = !{!"%4 <- %x.addr"}
!105 = !DILocation(line: 23, column: 18, scope: !97)
!106 = !{!"%5 <- %y.addr"}
!107 = !DILocation(line: 23, column: 16, scope: !97)
!108 = !{!"%mul3 <- %4 * %5"}
!109 = !DILocation(line: 23, column: 7, scope: !97)
!110 = !{!"%retval <- %mul3"}
!111 = !{!"timing ;  12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!112 = !DILocation(line: 24, column: 3, scope: !89)
!113 = !DILocation(line: 25, column: 10, scope: !55)
!114 = !{!"%6 <- %x.addr"}
!115 = !DILocation(line: 25, column: 3, scope: !55)
!116 = !{!"%retval <- %6"}
!117 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!118 = !DILocation(line: 26, column: 1, scope: !55)
!119 = !{!"%7 <- %retval"}
!120 = !{!"%ret <- %7; return <- T; if.end4 <- F; if.then2 <- F"}
!121 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)"}
!122 = distinct !DISubprogram(name: "baz", scope: !8, file: !8, line: 28, type: !9, scopeLine: 28, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!123 = !{!"timing ;  10+ 10+ 10+ 10+ 10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)"}
!124 = !{!"energy ;  50+ 50+ 50+ 50+ 50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)"}
!125 = !{!"entry <- F; for.cond <- F; for.body <- F; if.then.i <- F; if.then2.i <- F; if.end.i <- F; if.end4.i <- F; foo.exit <- F; for.inc <- F; for.end <- F"}
!126 = !{!"%retval.i <- 0.000000e+00"}
!127 = !{!"%x.addr.i <- 0.000000e+00"}
!128 = !{!"%y.addr.i <- 0.000000e+00"}
!129 = !{!"%a.i <- 0.000000e+00"}
!130 = !{!"%x.addr <- 0.000000e+00"}
!131 = !{!"%y.addr <- 0.000000e+00"}
!132 = !{!"%z <- 0.000000e+00"}
!133 = !{!"%i <- 0"}
!134 = !DILocalVariable(name: "x", arg: 1, scope: !122, file: !8, line: 28, type: !11)
!135 = !DILocation(line: 28, column: 19, scope: !122)
!136 = !DILocalVariable(name: "y", arg: 2, scope: !122, file: !8, line: 28, type: !11)
!137 = !DILocation(line: 28, column: 29, scope: !122)
!138 = !DILocalVariable(name: "z", scope: !122, file: !8, line: 31, type: !11)
!139 = !DILocation(line: 31, column: 10, scope: !122)
!140 = !DILocalVariable(name: "i", scope: !141, file: !8, line: 32, type: !58)
!141 = distinct !DILexicalBlock(scope: !122, file: !8, line: 32, column: 3)
!142 = !DILocation(line: 32, column: 12, scope: !141)
!143 = !{!"%i <- 1"}
!144 = !DILocation(line: 32, column: 8, scope: !141)
!145 = !{!"%entry%for.cond <- 1.00; entry <- T"}
!146 = !{!"timing ;  10+ 10+ 10+ 10+ 10+ 10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ 50+ 50+ 50+ 50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!147 = !DILocation(line: 32, column: 19, scope: !148)
!148 = distinct !DILexicalBlock(scope: !141, file: !8, line: 32, column: 3)
!149 = !{!"%0 <- %i"}
!150 = !DILocation(line: 32, column: 21, scope: !148)
!151 = !{!"%cmp <- %0 - 3; if (is.numeric(%cmp)) %cmp <- DiscreteDistribution(%cmp); %cmp <- p(%cmp)(-1)"}
!152 = !DILocation(line: 32, column: 3, scope: !141)
!153 = !{!"%for.cond%for.body <- round(%cmp, 2); %for.cond%for.end <- round(1 - %cmp, 2); for.cond <- T; for.inc <- F; entry <- F"}
!154 = !DILocation(line: 33, column: 14, scope: !155)
!155 = distinct !DILexicalBlock(scope: !148, file: !8, line: 32, column: 31)
!156 = !{!"%1 <- %x.addr"}
!157 = !DILocation(line: 33, column: 17, scope: !155)
!158 = !{!"%x.addr.i <- %1"}
!159 = !DILocation(line: 7, column: 50, scope: !7, inlinedAt: !160)
!160 = distinct !DILocation(line: 33, column: 10, scope: !155)
!161 = !{!"%y.addr.i <- %2"}
!162 = !DILocation(line: 7, column: 60, scope: !7, inlinedAt: !160)
!163 = !DILocation(line: 10, column: 7, scope: !24, inlinedAt: !160)
!164 = !{!"%3 <- %x.addr.i"}
!165 = !DILocation(line: 10, column: 11, scope: !24, inlinedAt: !160)
!166 = !{!"%4 <- %y.addr.i"}
!167 = !DILocation(line: 10, column: 13, scope: !24, inlinedAt: !160)
!168 = !{!"%add.i <- %4 + 6.000000e+00"}
!169 = !DILocation(line: 10, column: 9, scope: !24, inlinedAt: !160)
!170 = !{!"%cmp.i <- %3 - %add.i; if (is.numeric(%cmp.i)) %cmp.i <- DiscreteDistribution(%cmp.i); %cmp.i <- p(%cmp.i)(-0.01)"}
!171 = !DILocation(line: 10, column: 7, scope: !7, inlinedAt: !160)
!172 = !{!"%for.body%if.then.i <- round(%cmp.i, 2); %for.body%if.end4.i <- round(1 - %cmp.i, 2); for.body <- T; for.cond <- F"}
!173 = !{!"timing ;  12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!174 = !DILocation(line: 11, column: 12, scope: !32, inlinedAt: !160)
!175 = !DILocation(line: 11, column: 20, scope: !32, inlinedAt: !160)
!176 = !{!"%5 <- %y.addr.i"}
!177 = !DILocation(line: 11, column: 18, scope: !32, inlinedAt: !160)
!178 = !{!"%mul.i <- 2.000000e+00 * %5"}
!179 = !{!"%a.i <- %mul.i"}
!180 = !DILocation(line: 12, column: 9, scope: !37, inlinedAt: !160)
!181 = !{!"%6 <- %a.i"}
!182 = !DILocation(line: 12, column: 11, scope: !37, inlinedAt: !160)
!183 = !{!"%cmp1.i <- %6 - -2.000000e+00; if (is.numeric(%cmp1.i)) %cmp1.i <- DiscreteDistribution(%cmp1.i); %cmp1.i <- 1 - p(%cmp1.i)(0.01)"}
!184 = !DILocation(line: 12, column: 9, scope: !32, inlinedAt: !160)
!185 = !{!"%if.then.i%if.then2.i <- round(%cmp1.i, 2); %if.then.i%if.end.i <- round(1 - %cmp1.i, 2); if.then.i <- T; for.body <- F"}
!186 = !DILocation(line: 12, column: 24, scope: !37, inlinedAt: !160)
!187 = !{!"%7 <- %x.addr.i"}
!188 = !DILocation(line: 12, column: 28, scope: !37, inlinedAt: !160)
!189 = !{!"%8 <- %y.addr.i"}
!190 = !DILocation(line: 12, column: 26, scope: !37, inlinedAt: !160)
!191 = !{!"%mul3.i <- %7 * %8"}
!192 = !DILocation(line: 12, column: 17, scope: !37, inlinedAt: !160)
!193 = !{!"%retval.i <- %mul3.i"}
!194 = !{!"%if.then2.i%foo.exit <- 1.00; if.then2.i <- T; if.then.i <- F"}
!195 = !DILocation(line: 13, column: 3, scope: !32, inlinedAt: !160)
!196 = !{!"%if.end.i%if.end4.i <- 1.00; if.end.i <- T; if.then.i <- F"}
!197 = !DILocation(line: 14, column: 10, scope: !7, inlinedAt: !160)
!198 = !{!"%9 <- %x.addr.i"}
!199 = !DILocation(line: 14, column: 3, scope: !7, inlinedAt: !160)
!200 = !{!"%retval.i <- %9"}
!201 = !{!"%if.end4.i%foo.exit <- 1.00; if.end4.i <- T; if.end.i <- F; for.body <- F"}
!202 = !DILocation(line: 15, column: 1, scope: !7, inlinedAt: !160)
!203 = !{!"%10 <- %retval.i"}
!204 = !DILocation(line: 33, column: 7, scope: !155)
!205 = !{!"%11 <- %z"}
!206 = !{!"%add <- %11 + %10"}
!207 = !{!"%z <- %add"}
!208 = !DILocation(line: 34, column: 3, scope: !155)
!209 = !{!"%foo.exit%for.inc <- 1.00; foo.exit <- T; if.end4.i <- F; if.then2.i <- F"}
!210 = !DILocation(line: 32, column: 26, scope: !148)
!211 = !{!"%12 <- %i"}
!212 = !{!"%inc <- %12 + 1"}
!213 = !{!"%i <- %inc"}
!214 = !DILocation(line: 32, column: 3, scope: !148)
!215 = distinct !{!215, !152, !216}
!216 = !DILocation(line: 34, column: 3, scope: !141)
!217 = !{!"%for.inc%for.cond <- 1.00; for.inc <- T; foo.exit <- F"}
!218 = !{!"timing ;  12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!219 = !DILocation(line: 35, column: 10, scope: !122)
!220 = !{!"%13 <- %z"}
!221 = !DILocation(line: 35, column: 3, scope: !122)
!222 = !{!"%ret <- %13; for.end <- T; for.cond <- F"}
!223 = distinct !DISubprogram(name: "factorial", scope: !8, file: !8, line: 38, type: !224, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!224 = !DISubroutineType(types: !225)
!225 = !{!58, !58}
!226 = !{!"x <-DiscreteDistribution(supp = 1:5)"}
!227 = !{!"timing ;  10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1) 12+ 12 * DiscreteDistribution(1)"}
!228 = !{!"energy ;  50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1) 50+ DiscreteDistribution(supp = 12, prob = 1)"}
!229 = !{!"entry <- F; for.cond <- F; for.body <- F; for.inc <- F; for.end <- F"}
!230 = !{!"%x <- DiscreteDistribution(supp = 1:5)"}
!231 = !{!"%result <- 0"}
!232 = !DILocalVariable(name: "x", arg: 1, scope: !223, file: !8, line: 38, type: !58)
!233 = !DILocation(line: 38, column: 19, scope: !223)
!234 = !DILocalVariable(name: "result", scope: !223, file: !8, line: 40, type: !58)
!235 = !DILocation(line: 40, column: 7, scope: !223)
!236 = !{!"%result <- 1"}
!237 = !DILocalVariable(name: "i", scope: !238, file: !8, line: 41, type: !58)
!238 = distinct !DILexicalBlock(scope: !223, file: !8, line: 41, column: 3)
!239 = !DILocation(line: 41, column: 12, scope: !238)
!240 = !DILocation(line: 41, column: 8, scope: !238)
!241 = !{!"timing ;  10+ 10+ 10+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!242 = !DILocation(line: 41, column: 19, scope: !243)
!243 = distinct !DILexicalBlock(scope: !238, file: !8, line: 41, column: 3)
!244 = !DILocation(line: 41, column: 23, scope: !243)
!245 = !DILocation(line: 41, column: 21, scope: !243)
!246 = !{!"%cmp <- %0 - %1; if (is.numeric(%cmp)) %cmp <- DiscreteDistribution(%cmp); %cmp <- p(%cmp)(-1)"}
!247 = !DILocation(line: 41, column: 3, scope: !238)
!248 = !{!"timing ;  12+ 12+ 12 * DiscreteDistribution(1)+ 12 * DiscreteDistribution(1)", !"energy ;  50+ 50+ DiscreteDistribution(supp = 12, prob = 1)+ DiscreteDistribution(supp = 12, prob = 1)"}
!249 = !DILocation(line: 42, column: 11, scope: !250)
!250 = distinct !DILexicalBlock(scope: !243, file: !8, line: 41, column: 31)
!251 = !{!"%2 <- %result"}
!252 = !{!"%inc <- %2 + 1"}
!253 = !{!"%result <- %inc"}
!254 = !DILocation(line: 43, column: 3, scope: !250)
!255 = !{!"%for.body%for.inc <- 1.00; for.body <- T; for.cond <- F"}
!256 = !DILocation(line: 41, column: 26, scope: !243)
!257 = !{!"%3 <- %i"}
!258 = !{!"%inc1 <- %3 + 1"}
!259 = !{!"%i <- %inc1"}
!260 = !DILocation(line: 41, column: 3, scope: !243)
!261 = distinct !{!261, !247, !262}
!262 = !DILocation(line: 43, column: 3, scope: !238)
!263 = !{!"%for.inc%for.cond <- 1.00; for.inc <- T; for.body <- F"}
!264 = !DILocation(line: 44, column: 10, scope: !223)
!265 = !{!"%4 <- %result"}
!266 = !DILocation(line: 44, column: 3, scope: !223)
!267 = !{!"%ret <- %4; for.end <- T; for.cond <- F"}
