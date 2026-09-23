import {
  Button,
  Dimmer,
  Icon,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Floor = {
  id: number;
  name: string;
  occupied: BooleanLike;
  your_ship: BooleanLike;
  // VOIDCREW EDIT ADDITION BEGIN - OUTPOST_ELEVATOR_ACCESS
  accessible?: BooleanLike;
  // VOIDCREW EDIT ADDITION END - OUTPOST_ELEVATOR_ACCESS
};

type Data = {
  current_floor: number;
  moving: BooleanLike;
  linked: BooleanLike;
  floors: Floor[];
};

export const OutpostElevator = (props) => {
  const { data, act } = useBackend<Data>();
  const { current_floor, moving, linked, floors } = data;

  return (
    <Window width={300} height={420} theme="retro">
      <Window.Content>
        {!linked && <UnlinkedDimmer />}
        <Stack vertical fill>
          <Stack.Item>
            <NoticeBox info>
              <Icon name="location-dot" mr={1} />
              You are on:{' '}
              {current_floor === 0 ? 'Concourse' : `Berth ${current_floor}`}
            </NoticeBox>
          </Stack.Item>
          <Stack.Item grow>
            <Section fill scrollable title="Floors">
              {!!moving && <MovingDimmer />}
              <Stack vertical>
                {floors.map((floor) => {
                  // VOIDCREW EDIT CHANGE BEGIN - OUTPOST_ELEVATOR_ACCESS
                  /* ORIGINAL
                  <Stack.Item key={floor.id}>
                    <Button
                      fluid
                      ellipsis
                      fontSize="14px"
                      bold
                      textAlign="left"
                      icon={floor.your_ship ? 'star' : 'circle'}
                      color={floor.your_ship ? 'good' : 'default'}
                      selected={floor.id === current_floor}
                      disabled={!floor.occupied || floor.id === current_floor}
                      tooltip={
                        floor.id === current_floor
                          ? 'You are here.'
                          : floor.occupied
                            ? undefined
                            : 'Nothing is docked at this berth.'
                      }
                      onClick={() => act('goto', { id: floor.id })}
                    >
                      {`${floor.name}${floor.your_ship ? ' (your ship)' : ''}`}
                    </Button>
                  </Stack.Item>
                  */
                  const isAccessible =
                    floor.accessible ?? (floor.id === 0 || floor.your_ship);
                  const isCurrent = floor.id === current_floor;
                  const isOccupied = !!floor.occupied;
                  const isDisabled = !isOccupied || isCurrent || !isAccessible;

                  let icon = 'circle';
                  if (floor.your_ship) {
                    icon = 'star';
                  } else if (!isAccessible && floor.id !== 0) {
                    icon = 'lock';
                  }

                  let tooltip: string | undefined;
                  if (isCurrent) {
                    tooltip = 'You are here.';
                  } else if (!isOccupied) {
                    tooltip = 'Nothing is docked at this berth.';
                  } else if (!isAccessible) {
                    tooltip = 'Access restricted: ship crew only.';
                  }

                  return (
                    <Stack.Item key={floor.id}>
                      <Button
                        fluid
                        ellipsis
                        fontSize="14px"
                        bold
                        textAlign="left"
                        icon={icon}
                        color={floor.your_ship ? 'good' : 'default'}
                        selected={isCurrent}
                        disabled={isDisabled}
                        tooltip={tooltip}
                        onClick={() => act('goto', { id: floor.id })}
                      >
                        {`${floor.name}${floor.your_ship ? ' (your ship)' : ''}`}
                      </Button>
                    </Stack.Item>
                  );
                  // VOIDCREW EDIT CHANGE END - OUTPOST_ELEVATOR_ACCESS
                })}
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const MovingDimmer = () => {
  return (
    <Dimmer>
      <Stack vertical align="center">
        <Stack.Item>
          <Icon size={6} name="spinner" spin />
        </Stack.Item>
        <Stack.Item fontSize="16px">Moving...</Stack.Item>
      </Stack>
    </Dimmer>
  );
};

const UnlinkedDimmer = () => {
  return (
    <Dimmer>
      <Stack vertical align="center">
        <Stack.Item>
          <Icon size={6} name="exclamation" />
        </Stack.Item>
        <Stack.Item fontSize="16px">Out of service.</Stack.Item>
      </Stack>
    </Dimmer>
  );
};
