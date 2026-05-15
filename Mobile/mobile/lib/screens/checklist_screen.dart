
// ============================================
// SCREEN 8 & 9: CHECKLIST DE INSPEÇÃO
// ============================================

class ChecklistInspecaoScreen extends StatefulWidget {
  const ChecklistInspecaoScreen({super.key});

  @override
  State<<ChecklistInspecaoScreen> createState() => _ChecklistInspecaoScreenState();
}

class _ChecklistInspecaoScreenState extends State<<ChecklistInspecaoScreen> {
  final _formKey = GlobalKey<<FormState>();
  int _currentStep = 0;
  
  // Controllers
  final _programadorController = TextEditingController();
  final _dataController = TextEditingController(text: '15/05/2026');
  final _turnoController = TextEditingController(text: 'Manhã');
  final _tecnicoController = TextEditingController();
  final _observacoesController = TextEditingController();

  // Dropdown values
  String? _maquinaSelecionada;
  String? _tipoInspecao;
  
  // Checklist items
  final List<Map<String, dynamic>> checklistItems = [
    {'item': 'Verificar nível de óleo', 'status': null, 'obs': ''},
    {'item': 'Inspeção de correias', 'status': null, 'obs': ''},
    {'item': 'Limpeza de filtros', 'status': null, 'obs': ''},
    {'item': 'Verificação de lubrificação', 'status': null, 'obs': ''},
    {'item': 'Teste de segurança', 'status': null, 'obs': ''},
    {'item': 'Calibração de instrumentos', 'status': null, 'obs': ''},
  ];

  final List<String> maquinas = [
    'Torno CNC #01',
    'Fresadora Universal #02',
    'Solda MIG/MAG #01',
    'Centro de Usinagem CNC #05',
    'Torno Mecânico #08',
  ];

  final List<String> tiposInspecao = [
    'Preventiva',
    'Corretiva',
    'Predial',
    'Rotineira',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SENAIAppBar(
        title: 'Checklist de Inspeção',
        showMenu: false,
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() => _currentStep++);
            } else {
              _submitForm();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text(_currentStep == 2 ? 'Finalizar' : 'Continuar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: details.onStepCancel,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFB71C1C),
                          side: const BorderSide(color: Color(0xFFB71C1C)),
                        ),
                        child: const Text('Voltar'),
                      ),
                    ),
                ],
              ),
            );
          },
          steps: [
            // Step 1: Informações Gerais
            Step(
              title: const Text('Informações'),
              subtitle: const Text('Dados da inspeção'),
              isActive: _currentStep >= 0,
              content: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _maquinaSelecionada,
                    decoration: const InputDecoration(
                      labelText: 'Máquina',
                      prefixIcon: Icon(Icons.precision_manufacturing),
                    ),
                    items: maquinas.map((m) => DropdownMenuItem(
                      value: m,
                      child: Text(m),
                    )).toList(),
                    onChanged: (value) => setState(() => _maquinaSelecionada = value),
                    validator: (value) => value == null ? 'Selecione uma máquina' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _tipoInspecao,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de Inspeção',
                      prefixIcon: Icon(Icons.assignment_outlined),
                    ),
                    items: tiposInspecao.map((t) => DropdownMenuItem(
                      value: t,
                      child: Text(t),
                    )).toList(),
                    onChanged: (value) => setState(() => _tipoInspecao = value),
                    validator: (value) => value == null ? 'Selecione o tipo' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _dataController,
                    decoration: const InputDecoration(
                      labelText: 'Data da Inspeção',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _turnoController,
                    decoration: const InputDecoration(
                      labelText: 'Turno',
                      prefixIcon: Icon(Icons.access_time),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _programadorController,
                    decoration: const InputDecoration(
                      labelText: 'Programador',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _tecnicoController,
                    decoration: const InputDecoration(
                      labelText: 'Técnico Responsável',
                      prefixIcon: Icon(Icons.engineering_outlined),
                    ),
                  ),
                ],
              ),
            ),
            
            // Step 2: Verificação
            Step(
              title: const Text('Verificação'),
              subtitle: const Text('Itens do checklist'),
              isActive: _currentStep >= 1,
              content: Column(
                children: checklistItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB71C1C),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  item['item'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatusButton(
                                  label: 'OK',
                                  icon: Icons.check_circle,
                                  color: const Color(0xFF4CAF50),
                                  isSelected: item['status'] == 'OK',
                                  onTap: () => setState(() => checklistItems[index]['status'] = 'OK'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildStatusButton(
                                  label: 'NOK',
                                  icon: Icons.cancel,
                                  color: const Color(0xFFF44336),
                                  isSelected: item['status'] == 'NOK',
                                  onTap: () => setState(() => checklistItems[index]['status'] = 'NOK'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildStatusButton(
                                  label: 'NA',
                                  icon: Icons.remove_circle,
                                  color: Colors.grey,
                                  isSelected: item['status'] == 'NA',
                                  onTap: () => setState(() => checklistItems[index]['status'] = 'NA'),
                                ),
                              ),
                            ],
                          ),
                          if (item['status'] == 'NOK') ...[
                            const SizedBox(height: 12),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: 'Observação / Ação Corretiva',
                                hintText: 'Descreva o problema encontrado...',
                              ),
                              maxLines: 2,
                              onChanged: (value) => checklistItems[index]['obs'] = value,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            // Step 3: Conclusão
            Step(
              title: const Text('Conclusão'),
              subtitle: const Text('Finalização'),
              isActive: _currentStep >= 2,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFB71C1C).withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.assignment_turned_in, color: Color(0xFFB71C1C), size: 48),
                        const SizedBox(height: 12),
                        const Text(
                          'Resumo da Inspeção',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB71C1C),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow('Máquina', _maquinaSelecionada ?? '-'),
                        _buildSummaryRow('Tipo', _tipoInspecao ?? '-'),
                        _buildSummaryRow('Data', _dataController.text),
                        _buildSummaryRow('Técnico', _tecnicoController.text),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildCountBadge('OK', const Color(0xFF4CAF50), 
                              checklistItems.where((i) => i['status'] == 'OK').length),
                            _buildCountBadge('NOK', const Color(0xFFF44336), 
                              checklistItems.where((i) => i['status'] == 'NOK').length),
                            _buildCountBadge('Pendentes', Colors.grey, 
                              checklistItems.where((i) => i['status'] == null).length),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _observacoesController,
                    decoration: const InputDecoration(
                      labelText: 'Observações Gerais',
                      hintText: 'Observações finais sobre a inspeção...',
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    value: true,
                    activeColor: const Color(0xFFB71C1C),
                    title: const Text('Confirmo que todos os itens foram verificados'),
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton({
    required String label,
    required IconData icon,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[100],
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCountBadge(String label, Color color, int count) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  void _submitForm() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 64),
            const SizedBox(height: 16),
            const Text(
              'Inspeção Registrada!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'O checklist foi salvo com sucesso.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
