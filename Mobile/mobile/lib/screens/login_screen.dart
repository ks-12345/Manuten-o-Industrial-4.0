
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _lembrarMe = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB71C1C),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo SENAI
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.network(
                    'https://www.senai.br/wp-content/uploads/2020/01/logo-senai-1.png',
                    height: 60,
                    errorBuilder: (context, error, stackTrace) => 
                      const Text('SENAI', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFB71C1C))),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Card de Login
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Entrar na sua conta',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB71C1C),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Digite seus dados de acesso para acessar o sistema',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Tipo de Acesso
                      Row(
                        children: [
                          Expanded(
                            child: _buildAccessTypeButton(
                              icon: Icons.person_outline,
                              label: 'Usuário',
                              isSelected: true,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildAccessTypeButton(
                              icon: Icons.fingerprint,
                              label: 'Biometria',
                              isSelected: false,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Biometria não configurada')),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Email
                      const Text(
                        'EMAIL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'joao.oliveira@senai.br',
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Senha
                      const Text(
                        'SENHA',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _senhaController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () => setState(() => _obscureText = !_obscureText),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Lembrar-me e Esqueci senha
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _lembrarMe,
                                activeColor: const Color(0xFFB71C1C),
                                onChanged: (value) => setState(() => _lembrarMe = value!),
                              ),
                              const Text('Lembrar de mim', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const EsqueciSenhaScreen()));
                            },
                            child: const Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                color: Color(0xFFB71C1C),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Botão Entrar
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const DashboardScreen()),
                            );
                          },
                          icon: const Icon(Icons.login),
                          label: const Text('Entrar'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Versão 1.0.0 - SENAI',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccessTypeButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFFB71C1C) : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? const Color(0xFFFFEBEE) : Colors.white,
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFFB71C1C) : Colors.grey),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFFB71C1C) : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
