import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary     = Color(0xFFB71C1C);
  static const primaryLight = Color(0xFFEF5350);
  static const background  = Color(0xFF0F1117);
  static const surface     = Color(0xFF1A1D26);
  static const card        = Color(0xFF20232F);
  static const success     = Color(0xFF00C853);
  static const warning     = Color(0xFFFFD600);
  static const danger      = Color(0xFFD50000);
  static const info        = Color(0xFF2962FF);
  static const orange      = Color(0xFFFF6D00);
  static const textPrimary = Color(0xFFE8EAF0);
  static const textMuted   = Color(0xFF8B8FA8);
  static const border      = Color(0x14FFFFFF);

  static const machineStatusColors = {
    'ativo'      : success,
    'atencao'    : warning,
    'quebrada'   : danger,
    'manutencao' : info,
  };
}