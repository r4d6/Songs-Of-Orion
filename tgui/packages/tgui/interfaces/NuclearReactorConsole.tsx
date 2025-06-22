import { useBackend, useSharedState } from '../backend';
import { toFixed } from 'common/math';
import {
  Box,
  Button,
  Knob,
  LabeledControls,
  LabeledList,
  ProgressBar,
  Section,
  Tabs,
} from '../components';
import { Window } from '../layouts';

const logScale = (value: number) => Math.log2(16 + Math.max(0, value)) - 4;

interface fuelRod {
  gasefficiency: number;
  insertion: number;
  integrity: number;
  integrity_max: number;
  life: number;
  lifespan: number;
  reflective: number;
  temperature: number;
  specific_heat: number; // J/(mol*K) - Caluclated by: (specific heat) [kJ/kg*K] * (molar mass) [g/mol] (g/mol = kg/mol * 1000, duh.)
  molar_mass: number; // kg/mol
  mass: number; // kg
  melting_point: number; // Entering the danger zone.
  decay_heat: number;
}

interface controlRod {
  height: number;
  minHeight: number;
  maxHeight: number;
}

export const NuclearReactorConsole = (props, context) => {
  const { act, data } = useBackend<any>(context);
  // Extract `health` and `color` variables from the `data` object.
  const {
    integrity,
    control_average,
    temperature,
    cutoffTemp,
  }: {
    integrity: number;
    control_average: number;
    temperature: number;
    cutoffTemp: number;
  } = data;
  const [tab, setTab] = useSharedState(context, 'tab', 1);

  const hundredths = control_average
    ? Math.trunc((control_average * 100) % 10)
    : 0;
  const tenths = control_average ? Math.trunc((control_average * 10) % 10) : 0;
  const ones = control_average ? Math.trunc(control_average % 10) : 0;
  const tens = control_average ? Math.trunc(control_average / 10) : 0;

  const setReactorHeight = function (
    source: 'tens' | 'ones' | 'tenths' | 'hundredths',
    value: number,
  ) {
    const newTens = (source === 'tens' ? value : tens) * 10;
    const newOnes = source === 'ones' ? value : ones;
    const newTenths = (source === 'tenths' ? value : tenths) * 0.1;
    const newHundredths = (source === 'hundredths' ? value : hundredths) * 0.01;
    const new_value: number = newTens + newOnes + newTenths + newHundredths;
    act('set_target_height', { target_height: new_value });
    return;
  };

  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section title="Reactor status">
          <LabeledList>
            <LabeledList.Item label="Stack Integrity">
              <ProgressBar
                value={integrity / 100}
                ranges={{
                  good: [0.9, Infinity],
                  average: [0.5, 0.9],
                  bad: [-Infinity, 0.5],
                }}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Reaction Moderation">
              <LabeledControls>
                <LabeledControls.Item label={tens}>
                  <Knob
                    minValue={0}
                    maxValue={10}
                    step={1}
                    suppressFlicker={500}
                    value={tens}
                    onChange={(_, v: number) => {
                      setReactorHeight('tens', v);
                    }}
                    onDrag={(_, v: number) => {
                      setReactorHeight('tens', v);
                    }}
                  />
                </LabeledControls.Item>
                <LabeledControls.Item label={ones}>
                  <Knob
                    minValue={0}
                    maxValue={9}
                    step={1}
                    suppressFlicker={500}
                    value={ones}
                    onChange={(_, v: number) => {
                      setReactorHeight('ones', v);
                    }}
                    onDrag={(_, v: number) => {
                      setReactorHeight('ones', v);
                    }}
                  />
                </LabeledControls.Item>
                <LabeledControls.Item label="." />
                <LabeledControls.Item label={tenths}>
                  <Knob
                    minValue={0}
                    maxValue={9}
                    step={1}
                    suppressFlicker={500}
                    value={tenths}
                    onChange={(_, v: number) => {
                      setReactorHeight('tenths', v);
                    }}
                    onDrag={(_, v: number) => {
                      setReactorHeight('tenths', v);
                    }}
                  />
                </LabeledControls.Item>
                <LabeledControls.Item label={hundredths}>
                  <Knob
                    minValue={0}
                    maxValue={9}
                    step={1}
                    suppressFlicker={500}
                    value={hundredths}
                    onChange={(_, v: number) => {
                      setReactorHeight('hundredths', v);
                    }}
                    onDrag={(_, v: number) => {
                      setReactorHeight('hundredths', v);
                    }}
                  />
                </LabeledControls.Item>
              </LabeledControls>
              {/* <Slider
                value={control_average}
                minValue={0}
                maxValue={100}
                step={1}
                stepPixelSize={1.9}
                onDrag={(e, value) =>
                  act('set_target_height', { target_height: value })
                }
                onChange={(e, value) =>
                  act('set_target_height', { target_height: value })
                }
              /> */}
            </LabeledList.Item>
            <LabeledList.Item label="Temperature">
              <ProgressBar
                value={logScale(temperature)}
                minValue={0}
                maxValue={logScale(cutoffTemp * 1.2)}
                ranges={{
                  teal: [-Infinity, logScale(100)],
                  good: [logScale(100), logScale(300)],
                  average: [logScale(300), logScale(cutoffTemp)],
                  bad: [logScale(cutoffTemp), Infinity],
                }}
              >
                {toFixed(temperature, 2) + ' K'}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Reactor Trip">
              <Button
                disabled={control_average === 0}
                color="bad"
                content="SCRAM"
                onClick={() => act('scram')}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section>
          <Tabs>
            <Tabs.Tab
              icon="atom"
              lineHeight="23px"
              selected={tab === 1}
              onClick={() => setTab(1)}
            >
              Fissile Materials
            </Tabs.Tab>
            <Tabs.Tab
              icon="list"
              lineHeight="23px"
              selected={tab === 2}
              onClick={() => setTab(2)}
            >
              Moderator Status
            </Tabs.Tab>
            <Tabs.Tab
              icon="cloud"
              lineHeight="23px"
              selected={tab === 3}
              onClick={() => setTab(3)}
            >
              Fluid Dynamics
            </Tabs.Tab>
          </Tabs>
          {tab === 1 && <ReactorFuelRods />}
          {tab === 2 && <ReactorControlRods />}
          {tab === 3 && <ReactorFluidDynamics />}
        </Section>
        {/* <Section title="Control Rods">
          {controlRods !== null ? (
            controlRods.map((cr, i) => {
              ControlRods(cr, i, act);
            })
          ) : (
            <p>No Control Rods in Data</p>
          )}
        </Section> */}
      </Window.Content>
    </Window>
  );
};

const ReactorFuelRods = (props, context) => {
  const { data } = useBackend<any>(context);
  const { fuelRods }: { fuelRods: fuelRod[] } = data;

  return (
    <LabeledList>
      {fuelRods.map((fR, index) => {
        const low = Math.floor(fR.melting_point * 0.15);
        const med = Math.floor(fR.melting_point * 0.5);
        const high = Math.floor(fR.melting_point * 0.9);
        const bad = Math.floor(fR.melting_point * 1.2);
        return (
          <LabeledList.Item label={`Rod #${index + 1}`} key={index}>
            <Section title="Fissile Material">
              <ProgressBar
                value={fR.life}
                minValue={0}
                maxValue={100}
                ranges={{
                  bad: [-Infinity, 25],
                  average: [25, 50],
                  good: [50, 90],
                  teal: [90, Infinity],
                }}
              >
                {toFixed(fR.life, 2) + ' %'}
              </ProgressBar>
              <ProgressBar
                value={logScale(fR.temperature)}
                minValue={0}
                maxValue={logScale(bad)}
                ranges={{
                  bad: [logScale(high), Infinity],
                  average: [logScale(med), logScale(high)],
                  good: [logScale(low), logScale(med)],
                  teal: [-Infinity, logScale(low)],
                }}
              >
                {toFixed(fR.temperature, 2) + ' K'}
              </ProgressBar>
            </Section>
          </LabeledList.Item>
        );
      })}
    </LabeledList>
  );
};

const ReactorControlRods = (props, context) => {
  const { data } = useBackend<any>(context);
  const { controlRods }: { controlRods: controlRod[] } = data;
  return (
    <Box>
      <Section title="Moderator Retraction">
        <LabeledList>
          {controlRods.map((cR, index) => {
            return (
              <LabeledList.Item
                label={`Rod #${index + 1}`}
                key={`CR-${index.toString()}`}
              >
                <ProgressBar
                  minValue={cR.minHeight}
                  maxValue={cR.maxHeight}
                  value={cR.height}
                  ranges={{
                    bad: [-Infinity, 25],
                    average: [25, 50],
                    good: [50, 90],
                    teal: [90, Infinity],
                  }}
                >
                  {toFixed(cR.height, 2) + ' %'}
                </ProgressBar>
              </LabeledList.Item>
            );
          })}
        </LabeledList>
      </Section>
    </Box>
  );
};

type simpleGas = {
  temperature: number;
  gas: Record<string, number>[];
};

const ReactorFluidDynamics = (props, context) => {
  const { data } = useBackend<any>(context);
  const {
    gas_input,
    gas_output,
    gas_storage,
  }: { gas_input: simpleGas; gas_output: simpleGas; gas_storage: simpleGas } =
    data as any;
  return (
    <Box>
      <Section title="Input Gas">
        {gas_input.temperature} K<br />
        {Object.entries(gas_input.gas).map(([key, value]) => (
          <p>
            <strong>{key}</strong>: {value}
          </p>
        ))}
      </Section>
      <Section title="Internal Storage">
        {gas_storage.temperature} K<br />
        {Object.entries(gas_storage.gas).map(([key, value]) => (
          <p>
            <strong>{key}</strong>: {value}
          </p>
        ))}
      </Section>
      <Section title="Output Gas">
        {gas_output.temperature} K<br />
        {Object.entries(gas_output.gas).map(([key, value]) => (
          <p>
            <strong>{key}</strong>: {value}
          </p>
        ))}
      </Section>
    </Box>
  );
};
