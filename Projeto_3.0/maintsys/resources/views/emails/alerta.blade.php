<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Alerta de Manutenção - Manutenção Industrial 4.0</title>
</head>
<body style="margin:0; padding:0; background-color:#0b1220;">

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#0b1220;">
    <tr>
        <td align="center" style="padding:24px 12px;">

            <table role="presentation" width="600" cellpadding="0" cellspacing="0" border="0" style="width:100%; max-width:600px; background-color:#0f1b2d; border-radius:12px; overflow:hidden; box-shadow:0 10px 30px rgba(0,0,0,0.35);">

                <!-- Header -->
                <tr>
                    <td style="padding:20px 20px 16px 20px; background: linear-gradient(90deg, #0f2a4a 0%, #0b4f8a 100%);">
                        <div style="font-family:Arial, sans-serif; color:#eaf2ff; font-size:14px; letter-spacing:0.3px;">
                            MANUTENÇÃO INDUSTRIAL 4.0
                        </div>
                        <div style="font-family:Arial, sans-serif; color:#ffffff; font-size:18px; font-weight:700; margin-top:6px;">
                            🚨 Atualização de Chamado de Manutenção
                        </div>
                        <div style="font-family:Arial, sans-serif; color:#cfe2ff; font-size:13px; margin-top:6px;">
                            Um novo registro foi gerado no sistema.
                        </div>
                    </td>
                </tr>

                <!-- Body -->
                <tr>
                    <td style="padding:20px;">

                        <!-- Urgência Banner -->
                        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-bottom:14px;">
                            <tr>
                                <td style="background-color:#b42318; border-radius:10px; padding:14px 14px;">
                                    <div style="font-family:Arial, sans-serif; color:#ffffff; font-size:12px; text-transform:uppercase; letter-spacing:0.6px;">
                                        Prioridade / Nível de Urgência
                                    </div>
                                    <div style="font-family:Arial, sans-serif; color:#ffffff; font-size:16px; font-weight:800; margin-top:6px;">
                                        {{ $urgencia }}
                                    </div>
                                </td>
                            </tr>
                        </table>

                        <!-- Details -->
                        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="border:1px solid rgba(255,255,255,0.12); border-radius:12px;">
                            <tr>
                                <td style="padding:14px;">

                                    <!-- Row 1 -->
                                    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td style="font-family:Arial, sans-serif; color:#9fb3d6; font-size:12px; width:50%; padding:6px 0;">Código da Ordem de Serviço</td>
                                            <td style="font-family:Arial, sans-serif; color:#ffffff; font-size:14px; font-weight:700; width:50%; padding:6px 0; text-align:right;">{{ $codigoOrdemServico }}</td>
                                        </tr>
                                    </table>

                                    <!-- Row 2 -->
                                    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td style="font-family:Arial, sans-serif; color:#9fb3d6; font-size:12px; width:50%; padding:6px 0;">Máquina / Equipamento</td>
                                            <td style="font-family:Arial, sans-serif; color:#ffffff; font-size:14px; font-weight:700; width:50%; padding:6px 0; text-align:right;">{{ $maquina }}</td>
                                        </tr>
                                    </table>

                                    <!-- Row 3 -->
                                    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td style="font-family:Arial, sans-serif; color:#9fb3d6; font-size:12px; width:50%; padding:6px 0;">Setor</td>
                                            <td style="font-family:Arial, sans-serif; color:#ffffff; font-size:14px; font-weight:700; width:50%; padding:6px 0; text-align:right;">{{ $setor }}</td>
                                        </tr>
                                    </table>

                                    <!-- Row 4 -->
                                    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td style="font-family:Arial, sans-serif; color:#9fb3d6; font-size:12px; width:50%; padding:6px 0;">Técnico Responsável</td>
                                            <td style="font-family:Arial, sans-serif; color:#ffffff; font-size:14px; font-weight:700; width:50%; padding:6px 0; text-align:right;">{{ $tecnico }}</td>
                                        </tr>
                                    </table>

                                    <div style="height:1px; background-color:rgba(255,255,255,0.12); margin:12px 0;"></div>

                                    <!-- Description -->
                                    <div style="font-family:Arial, sans-serif; color:#9fb3d6; font-size:12px; margin-bottom:6px;">
                                        Descrição do Problema
                                    </div>
                                    <div style="font-family:Arial, sans-serif; color:#eaf2ff; font-size:14px; line-height:1.5; font-weight:600;">
                                        {{ $descricaoProblema }}
                                    </div>

                                </td>
                            </tr>
                        </table>

                        <!-- CTA -->
                        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-top:18px;">
                            <tr>
                                <td align="center">
                                    <a href="https://painel.seusistema.exemplo/chamados/{{ $codigoOrdemServico }}"
                                       style="display:inline-block; background-color:#2563eb; color:#ffffff; text-decoration:none; font-family:Arial, sans-serif; font-size:14px; font-weight:800; padding:12px 18px; border-radius:10px;">
                                        Ver chamado no painel
                                    </a>
                                </td>
                            </tr>
                        </table>

                        <div style="font-family:Arial, sans-serif; color:#a9c0e6; font-size:12px; line-height:1.5; margin-top:14px;">
                            Caso o link não funcione, copie e cole no navegador:
                            <span style="color:#eaf2ff;">painel.seusistema.exemplo/chamados/{{ $codigoOrdemServico }}</span>
                        </div>

                    </td>
                </tr>

                <!-- Footer -->
                <tr>
                    <td style="padding:16px 20px; background-color:#0b1220; border-top:1px solid rgba(255,255,255,0.10);">
                        <div style="font-family:Arial, sans-serif; color:#7f95bd; font-size:12px; line-height:1.5;">
                            Este é um e-mail automático do sistema <strong>Manutenção Industrial 4.0</strong>. 
                            Não responda diretamente a esta mensagem.
                        </div>
                    </td>
                </tr>

            </table>

        </td>
    </tr>
</table>

</body>
</html>

