import {interpolate, spring, useCurrentFrame, useVideoConfig} from 'remotion';
import {theme} from '../theme';

export const TitleCard: React.FC = () => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const entrance = spring({
    frame,
    fps,
    config: {damping: 18, stiffness: 100},
  });

  const exit = interpolate(frame, [120, 150], [1, 0], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
  });

  return (
    <div
      style={{
        position: 'absolute',
        top: '35%',
        left: '10%',
        right: '10%',
        opacity: entrance * exit,
        transform: `translateY(${interpolate(entrance, [0, 1], [50, 0])}px)`,
        textAlign: 'center',
        color: theme.colors.white,
        fontFamily: 'Inter, Arial, sans-serif',
        fontSize: 76,
        fontWeight: 800,
        lineHeight: 1.15,
      }}
    >
      Geleceği
      <br />
      Tasarla
      <div
        style={{
          width: 150,
          height: 8,
          borderRadius: 8,
          backgroundColor: theme.colors.accent,
          margin: '38px auto 0',
        }}
      />
    </div>
  );
};
