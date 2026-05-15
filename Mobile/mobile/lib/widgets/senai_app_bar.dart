
// AppBar padrão SENAI
class SENAIAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenu;
  final VoidCallback? onMenuPressed;

  const SENAIAppBar({
    super.key,
    required this.title,
    this.showMenu = true,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFB71C1C),
      foregroundColor: Colors.white,
      elevation: 0,
      leading: showMenu
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: onMenuPressed ?? () => Scaffold.of(context).openDrawer(),
            )
          : null,
      title: Row(
        children: [
          Image.network(
            'https://www.senai.br/wp-content/uploads/2020/01/logo-senai-1.png',
            height: 30,
            errorBuilder: (context, error, stackTrace) => 
              const Text('SENAI', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 18)),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
