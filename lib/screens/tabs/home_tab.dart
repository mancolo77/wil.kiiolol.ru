import 'package:flutter/material.dart';
import '../../services/user_progress_service.dart';
import '../../theme/app_theme.dart';

class ArticleItem {
  final String id;
  final String category;
  final String title;
  final String summary;
  final String content;
  final String readTime;

  const ArticleItem({
    required this.id,
    required this.category,
    required this.title,
    required this.summary,
    required this.content,
    required this.readTime,
  });
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final UserProgressService _progress = UserProgressService();

  // Daily Quiz state
  int _selectedQuizAnswer = -1;
  bool _quizSubmitted = false;

  final List<ArticleItem> _articles = const [
    ArticleItem(
      id: 'art_1',
      category: 'Тактика и стратегия',
      title: 'Прессинг в современном футболе: эволюция и схемы',
      summary: 'Разбираем, как высокий контрпрессинг изменил динамику матчей за последнее десятилетие.',
      content: 'Современный футбол требует от команд максимальной интенсивности уже на чужой половине поля. Контрпрессинг (или гегенпрессинг) заключается в немедленной попытке вернуть контроль над мячом в первые 5-6 секунд после потери.\n\nКлючевые принципы:\n• Компактность линий: расстояние между защитой и нападающими не должно превышать 30-35 метров.\n• Направление отбора: блокирование наиболее опасных линий передач и вытеснение соперника к бровке.\n• Физическая выносливость: футболисты пробегают до 12 км за матч в высоком темпе спринтов.',
      readTime: '3 мин',
    ),
    ArticleItem(
      id: 'art_2',
      category: 'История спорта',
      title: 'Рекорды скорости и выносливости на ледовых аренах',
      summary: 'Как экипировка и тренировочный процесс сделали хоккей одной из самых быстрых игр планеты.',
      content: 'Скорость полета шайбы после мощного щелчка может превышать 170 км/ч. Игроки проводят на льду короткие смены по 40-45 секунд с максимальной отдачей.\n\nБлагодаря композитным клюшкам и легким карбоновым конькам маневренность хоккеистов выросла на 25% по сравнению с экипировкой 90-х годов.',
      readTime: '4 мин',
    ),
    ArticleItem(
      id: 'art_3',
      category: 'Подготовка атлетов',
      title: 'Восстановление и гидратация в игровых видах спорта',
      summary: 'Научные методы поддержания максимальной концентрации на заключительных минутах встречи.',
      content: 'Потеря всего 2% жидкости от массы тела снижает скорость принятия решений спортсменом на 15%. Спортивные нутрициологи рассчитывают индивидуальные электролитные растворы для каждого тайма.',
      readTime: '2 мин',
    ),
  ];

  final List<String> _facts = [
    'Футбольный мяч сохраняет сферическую форму благодаря 32 водонепроницаемым панелям.',
    'В баскетболе средняя высота прыжка игрока при подборе составляет от 70 до 95 сантиметров.',
    'Хоккейная шайба перед официальной игрой обязательно замораживается, чтобы не пружинить на льду.',
  ];

  void _openArticleDetails(ArticleItem article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final isSaved = _progress.savedArticleIds.contains(article.id);
            return Container(
              padding: const EdgeInsets.all(AppTheme.screenPadding),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppTheme.border,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            article.category,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                            color: isSaved ? AppTheme.primary : AppTheme.textSecondary,
                          ),
                          onPressed: () {
                            _progress.toggleSaveArticle(article.id);
                            setModalState(() {});
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Время чтения: ${article.readTime}',
                      style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: AppTheme.border),
                    const SizedBox(height: 16),
                    Text(
                      article.content,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppTheme.textPrimary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: AppTheme.buttonHeight,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Понятно'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progress,
      builder: (context, _) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppTheme.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Главная',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceAccent,
                      borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.stars_rounded, color: AppTheme.primary, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          '${_progress.points} очков',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Спортивные обзоры, аналитика и факты дня',
                style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 20),

              // 1. Викторина дня (Интерактивный блок)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  border: Border.all(color: AppTheme.secondaryLine.withAlpha(120)),
                  boxShadow: AppTheme.cardShadow,
                  gradient: const LinearGradient(
                    colors: [
                      AppTheme.cardBackground,
                      Color(0xFF222255),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withAlpha(35),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.flash_on_rounded, color: AppTheme.primary, size: 22),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'ВИКТОРИНА ДНЯ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.navBackground,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '+30 баллов',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Сколько минут чистого времени длится хоккейный период?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Options
                    ...[
                      '15 минут',
                      '20 минут',
                      '25 минут',
                    ].asMap().entries.map((entry) {
                      final idx = entry.key;
                      final optionText = entry.value;
                      final isSelected = _selectedQuizAnswer == idx;
                      final isCorrect = (idx == 1);

                      Color btnColor = AppTheme.surfaceAccent;
                      if (_quizSubmitted) {
                        if (isCorrect) btnColor = const Color(0xFF1B5E20);
                        if (isSelected && !isCorrect) btnColor = const Color(0xFFB71C1C);
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: InkWell(
                          onTap: _quizSubmitted
                              ? null
                              : () {
                                  setState(() {
                                    _selectedQuizAnswer = idx;
                                    _quizSubmitted = true;
                                    if (isCorrect) {
                                      _progress.recordQuizCompleted(30);
                                    }
                                  });
                                },
                          borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: btnColor,
                              borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
                              border: Border.all(
                                color: isSelected ? AppTheme.primary : AppTheme.border,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  optionText,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                const Spacer(),
                                if (_quizSubmitted && isCorrect)
                                  const Icon(Icons.check_circle_rounded, color: Colors.greenAccent, size: 20)
                                else if (_quizSubmitted && isSelected && !isCorrect)
                                  const Icon(Icons.cancel_rounded, color: Colors.redAccent, size: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Спортивные статьи
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Спортивные статьи',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ..._articles.map((art) {
                final isSaved = _progress.savedArticleIds.contains(art.id);
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                    border: Border.all(color: AppTheme.border),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: InkWell(
                    onTap: () => _openArticleDetails(art),
                    borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceAccent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  art.category,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: Icon(
                                  isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                  color: isSaved ? AppTheme.primary : AppTheme.textSecondary,
                                  size: 22,
                                ),
                                onPressed: () => _progress.toggleSaveArticle(art.id),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            art.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            art.summary,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Чтение: ${art.readTime}',
                                style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                              ),
                              Row(
                                children: const [
                                  Text(
                                    'Читать',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_rounded, color: AppTheme.primary, size: 16),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),

              // 3. Интересные факты
              const Text(
                'Спортивный факт',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.navBackground,
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_outline_rounded, color: AppTheme.primary, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _facts[DateTime.now().second % _facts.length],
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

