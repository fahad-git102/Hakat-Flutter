import 'package:flutter/material.dart';

class ChaosModeToggle extends StatefulWidget {
  final bool initialValue;
  final Function(bool)? onChanged;

  const ChaosModeToggle({
    Key? key,
    this.initialValue = false,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ChaosModeToggle> createState() => _ChaosModeToggleState();
}

class _ChaosModeToggleState extends State<ChaosModeToggle>
    with SingleTickerProviderStateMixin {
  bool isOn = false;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: const Color(0xFF6B7280), // Gray color for OFF
      end: const Color(0xFFD4AF37), // Golden color for ON
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (isOn) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      isOn = !isOn;
      if (isOn) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    if (widget.onChanged != null) {
      widget.onChanged!(isOn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            height: 65,
            decoration: BoxDecoration(
            //  color: const Color(0xFF2D2D2D),
              gradient: LinearGradient(colors: [Color(0xFF201C27).withOpacity(0.8),Color(0xFF282433).withOpacity(0.7)]),// Dark background
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 15),
              child: Row(
                children: [
                  // Left side - Chaos Mode text
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Chaos Mode',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Garamond",
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),

                  // Right side - Toggle switch
            Container(
              width: 55,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF313A5B).withOpacity(0.9),
                    const Color(0xFF1F253E).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // OFF text
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: isOn ? 1 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: const Text(
                          'OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ON text
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: isOn ? 1.0 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: const Text(
                          'ON',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Sliding toggle button
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: isOn ? 29 : 2,
                    top: 2,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: _colorAnimation.value,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )


            ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class SettingToggle extends StatefulWidget {
  final bool initialValue;
  final Function(bool)? onChanged;
  final String title ;
  const SettingToggle({ Key? key,
    this.initialValue = false,
    required this.title,
    this.onChanged,});

  @override
  State<SettingToggle> createState() => _SettingToggleState();
}

class _SettingToggleState extends State<SettingToggle>
    with SingleTickerProviderStateMixin {
  bool isOn = false;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: const Color(0xFF6B7280), // Gray color for OFF
      end: const Color(0xFFD4AF37), // Golden color for ON
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (isOn) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      isOn = !isOn;
      if (isOn) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    if (widget.onChanged != null) {
      widget.onChanged!(isOn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return  Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  // Left side - Chaos Mode text
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 16),
                      child:  Text(
                        widget.title,
                        style: TextStyle(
                          color: Color(0xFFA79EBB),
                          fontSize: 14,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),

                  // Right side - Toggle switch
                  Container(
                    width: 55,
                    height: 30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF313A5B).withOpacity(0.9),
                          const Color(0xFF1F253E).withOpacity(0.9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        // OFF text
                        Positioned(
                          left: 8,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: AnimatedOpacity(
                              opacity: isOn ? 1 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: const Text(
                                'OFF',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ON text
                        Positioned(
                          right: 8,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: AnimatedOpacity(
                              opacity: isOn ? 1.0 : 1,
                              duration: const Duration(milliseconds: 200),
                              child: const Text(
                                'ON',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Sliding toggle button
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          left: isOn ? 29 : 2,
                          top: 2,
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: _colorAnimation.value,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )


                ],
              ),
            );
        },
      ),
    );
  }
}

