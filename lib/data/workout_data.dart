class WorkoutData {
  static const Map<String, List<Map<String, dynamic>>> workoutsByDifficulty = {
    'Beginner': [
      {
        'title': 'Push-ups',
        'duration': '10 min',
        'calories': '50 kcal',
        'description': 'Basic push-ups to build upper body strength. Start with knees on ground if needed.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
        'steps': ['Start in plank position','Lower body to floor','Push back up','Repeat 3 sets of 10']
      },
      {
        'title': 'Squats',
        'duration': '15 min',
        'calories': '80 kcal',
        'description': 'Basic bodyweight squats to strengthen legs and glutes.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
        'steps': ['Stand feet shoulder-width','Lower as if sitting','Keep chest up','Return to stand','3 sets of 15 reps']
      },
      {
        'title': 'Plank Hold',
        'duration': '8 min',
        'calories': '40 kcal',
        'description': 'Core strengthening exercise. Hold plank position to build stability.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
        'steps': ['Forearm plank position','Keep body straight','Engage core','Hold 30 seconds']
      },
      {
        'title': 'Walking Lunges',
        'duration': '12 min',
        'calories': '65 kcal',
        'description': 'Leg exercise that improves balance and strengthens lower body.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
        'steps': ['Stand tall','Step forward and lower','Both knees at 90 degrees','Alternate legs','3 sets of 10 each']
      },
    ],
    'Intermediate': [
      {
        'title': 'Burpees',
        'duration': '15 min',
        'calories': '120 kcal',
        'description': 'Full body exercise combining strength and cardio. Great for fat burning.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
        'steps': ['Drop to squat','Kick feet to plank','Do push-up','Jump feet back','Jump up','3 sets of 12']
      },
      {
        'title': 'Mountain Climbers',
        'duration': '12 min',
        'calories': '100 kcal',
        'description': 'Dynamic core and cardio exercise. Burns calories while building strength.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
        'steps': ['High plank position','Bring knee to chest','Quickly switch legs','Fast pace','3 sets of 30 seconds']
      },
      {
        'title': 'Jump Squats',
        'duration': '10 min',
        'calories': '95 kcal',
        'description': 'Explosive leg exercise that builds power and burns fat.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
        'steps': ['Start in squat','Explode up jumping','Land softly','Repeat immediately','3 sets of 15']
      },
      {
        'title': 'Bicycle Crunches',
        'duration': '10 min',
        'calories': '70 kcal',
        'description': 'Core exercise targeting obliques and abs.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
        'steps': ['Lie on back','Hands behind head','Elbow to opposite knee','Cycling motion','3 sets of 20 each side']
      },
    ],
    'Advanced': [
      {
        'title': 'Pistol Squats',
        'duration': '15 min',
        'calories': '110 kcal',
        'description': 'Single-leg squat requiring strength, balance, and flexibility.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4',
        'steps': ['Stand on one leg','Other leg extended forward','Lower to deep squat','Keep leg off ground','3 sets of 8 each']
      },
      {
        'title': 'Muscle-ups',
        'duration': '20 min',
        'calories': '150 kcal',
        'description': 'Advanced pull-up variation combining pull and dip motion.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
        'steps': ['Hang from bar','Pull explosively up','Transition to dip','Push to support','3 sets of 5']
      },
      {
        'title': 'Handstand Push-ups',
        'duration': '15 min',
        'calories': '130 kcal',
        'description': 'Inverted push-up against wall. Extreme shoulder and arm workout.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4',
        'steps': ['Kick up to handstand','Lower head to ground','Push back up','Keep core tight','3 sets of 6']
      },
      {
        'title': 'Dragon Flags',
        'duration': '12 min',
        'calories': '100 kcal',
        'description': 'Advanced core exercise requiring full body tension.',
        'videoUrl': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        'steps': ['Lie on bench','Grab behind head','Lift body off bench','Lower with control','3 sets of 5']
      },
    ],
  };
}
