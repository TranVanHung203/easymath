import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/common/cubit/is_authorized_cubit.dart';
import 'package:math/core/services/voice_service.dart';
import 'package:math/features/home/presentation/widgets/dashboard_appbar.dart';
import 'package:math/features/home/view_models/roadmap_cubit.dart';
import 'package:math/features/home/presentation/pages/roadmap.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final RoadmapCubit _roadmapCubit;
  late final IsAuthorizedCubit _isAuthorizedCubit;
  late final PageController _pageController;
  late AudioPlayer player = AudioPlayer();

  int _currentSkillIndex = 0;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    _roadmapCubit = context.read<RoadmapCubit>();
    _isAuthorizedCubit = context.read<IsAuthorizedCubit>();
    _pageController = PageController(initialPage: 0);
    _roadmapCubit.getRoadmaps(chapterId: '693f88c93320266f98d13f32');
  }

  @override
  void dispose() {
    player.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RoadmapCubit, RoadmapState>(
        builder: (context, state) {
          print('ROADMAP STATE: $state');
          if (state is RoadmapsLoaded) {
            final skills = state.roadmap.skills;
            print('SỐ SKILL: ${skills.length}');
            for (var s in skills) {
              print('Skill: ${s.skillName}');
            }

            if (skills.isEmpty) {
              return Column(
                children: [
                  DashboardAppbar(
                    title: 'Không có skill',
                    onBack: () => _isAuthorizedCubit.logout(),
                    onMenu: () {},
                    onVoice: () {},
                  ),
                  Center(child: Text('Không có skill trong roadmap')),
                ],
              );
            }

            // Đảm bảo index không bị out-of-range
            final currentIndex = _currentSkillIndex.clamp(0, skills.length - 1);

            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: DashboardAppbar(
                      currentIndex: currentIndex,
                      title: skills[currentIndex].skillName,
                      onBack: () {
                        _isAuthorizedCubit.logout();
                      },
                      onMenu: () {},
                      onVoice: () {
                        VoiceService.instance.speak(
                          skills[currentIndex].skillName ?? '',
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      pageSnapping: false,
                      itemCount: skills.length,
                      onPageChanged: (index) {
                        print('ĐANG Ở TRANG: $index');
                        setState(() {
                          _currentSkillIndex = index;
                        });
                      },
                      itemBuilder: (context, i) {
                        return Center(
                          child: DuoHorizontalPage(
                            skill: skills[i],
                            roadmap: state.roadmap,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          // Trạng thái khác (loading, error, initial)
          return Column(
            children: [
              DashboardAppbar(
                title: 'Đang tải...',
                onBack: () {
                  _isAuthorizedCubit.logout();
                },
                onMenu: () {},
                onVoice: () {},
              ),
              const Expanded(child: Center(child: CircularProgressIndicator())),
            ],
          );
        },
      ),
    );
  }
}
