import {AbsoluteFill, interpolate, useCurrentFrame} from 'remotion';
import {theme} from '../theme';

export const Backdrop: React.FC = () => {
  const frame = useCurrentFrame();

  const progress = interpolate(frame, [0, 149], [0, 1]);

  return (
    <AbsoluteFill
      style={{
        background: `linear-gradient(145deg, ${theme.colors.backgroundStart}, ${theme.colors.backgroundEnd})`,
        transform: `scale(${1 + progress * 0.025})`,
      }}
    />
  );
};
