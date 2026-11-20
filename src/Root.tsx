import {Composition} from 'remotion';
import {Test5s} from './compositions/Test5s';
import {theme} from './theme';

export const RemotionRoot: React.FC = () => {
  return (
    <Composition
      id="Test5s"
      component={Test5s}
      durationInFrames={theme.video.durationInFrames}
      fps={theme.video.fps}
      width={theme.video.width}
      height={theme.video.height}
    />
  );
};
