import {AbsoluteFill, Sequence, useCurrentFrame, interpolate} from 'remotion';
import {Backdrop} from '../components/Backdrop';
import {TitleCard} from '../components/TitleCard';

export const Test5s: React.FC = () => {
  const frame = useCurrentFrame();

  const fadeIn = interpolate(frame, [0, 20], [0, 1], {
    extrapolateRight: 'clamp',
  });

  const fadeOut = interpolate(frame, [130, 149], [1, 0], {
    extrapolateLeft: 'clamp',
  });

  return (
    <AbsoluteFill style={{opacity: fadeIn * fadeOut}}>
      <Backdrop />
      <Sequence from={0} durationInFrames={150}>
        <TitleCard />
      </Sequence>
    </AbsoluteFill>
  );
};
