import 'package:flutter/material.dart';
import '../../services/user_progress_service.dart';
import '../../theme/app_theme.dart';

class BadgeItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  const BadgeItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class ProgressTab extends StatelessWidget {
  const ProgressTab({super.key});

  final List<BadgeItem> _badges = const [
    BadgeItem(
      id: 'badge_starter',
      title: 'Первый шаг',
      description: 'Успешный старт в спортивном центре',
      icon: Icons.flag_rounded,
    ),
    BadgeItem(
      id: 'badge_first_quiz',
      title: 'Знаток фактов',
      description: 'Пройдена первая викторина дня',
      icon: Icons.flash_on_rounded,
    ),
    BadgeItem(
      id: 'badge_reader',
      title: 'Аналитик',
      description: 'Сохранена интересная статья',
      icon: Icons.menu_book_rounded,
    ),
    BadgeItem(
      id: 'badge_fan',
      title: 'Преданный болельщик',
      description: 'Добавлено 2 матча в избранное',
      icon: Icons.star_rounded,
    ),
    BadgeItem(
      id: 'badge_amateur',
      title: 'Спортивный Любитель',
      description: 'Набрано более 300 баллов активности',
      icon: Icons.military_tech_rounded,
    ),
    BadgeItem(
      id: 'badge_expert',
      title: 'Мастер Спорта',
      description: 'Достигнут максимальный 3 уровень',
      icon: Icons.workspace_premium_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final progress = UserProgressService();

    return AnimatedBuilder(
      animation: progress,
      builder: (context, _) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppTheme.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Мой прогресс',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Личные баллы, уровни и виртуальные значки',
                style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 20),

              // 1. Уровень участника (3 уровня)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  border: Border.all(color: AppTheme.secondaryLine.withAlpha(150)),
                  boxShadow: AppTheme.cardShadow,
                  gradient: const LinearGradient(
                    colors: [
                      AppTheme.cardBackground,
                      Color(0xFF20204D),
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
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceAccent,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppTheme.primary, width: 2),
                          ),
                          child: const Center(
                            child: Icon(Icons.emoji_events_rounded, color: AppTheme.primary, size: 30),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppTheme.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'УРОВЕНЬ ${progress.levelNumber} ИЗ 3',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.onPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                progress.levelName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${progress.points} баллов активности',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                        Text(
                          progress.levelNumber < 3 ? 'До след. уровня: 700' : 'Максимальный ранг',
                          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress.levelProgress,
                        minHeight: 10,
                        backgroundColor: AppTheme.navBackground,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Статистика активности
              const Text(
                'Активность',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Викторины',
                      value: '${progress.quizzesCompleted}',
                      icon: Icons.quiz_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Сохранено статей',
                      value: '${progress.savedArticleIds.length}',
                      icon: Icons.bookmark_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Матчи в избранном',
                      value: '${progress.favoriteMatchIds.length}',
                      icon: Icons.star_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 3. Виртуальные значки
              const Text(
                'Виртуальные значки',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ..._badges.map((badge) {
                final isUnlocked = progress.unlockedBadges.contains(badge.id);
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                    border: Border.all(
                      color: isUnlocked ? AppTheme.primary.withAlpha(120) : AppTheme.border,
                    ),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isUnlocked ? AppTheme.primary.withAlpha(30) : AppTheme.navBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isUnlocked ? AppTheme.primary : AppTheme.border,
                          ),
                        ),
                        child: Icon(
                          badge.icon,
                          color: isUnlocked ? AppTheme.primary : AppTheme.textSecondary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              badge.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              badge.description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isUnlocked)
                        const Icon(Icons.check_circle_rounded, color: AppTheme.primary, size: 20)
                      else
                        const Icon(Icons.lock_outline_rounded, color: AppTheme.textSecondary, size: 18),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),

              // 4. Дисклеймер
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.navBackground,
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.info_outline_rounded, color: AppTheme.primary, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Баллы отражают только личную активность, их нельзя покупать, передавать или обменивать. Приложение создано для любителей спорта.',
                        style: TextStyle(
                          fontSize: 12,
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

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primary, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

