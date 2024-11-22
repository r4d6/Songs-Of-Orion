import { useBackend } from '../backend';
import { toFixed } from 'common/math';
import { Button, LabeledList, ProgressBar, Section, Slider } from '../components';
import { Window } from '../layouts';

const logScale = (value) => Math.log2(16 + Math.max(0, value)) - 4;

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
  const { act, data } = useBackend(context);
  // Extract `health` and `color` variables from the `data` object.
  const {
    integrity,
    control_average,
    temperature,
    cutoffTemp,
    gas_input,
    gas_output,
    fuelRods,
    controlRods,
  }: {
    integrity: number;
    control_average: number;
    temperature: number;
    cutoffTemp: number;
    gas_input: unknown;
    gas_output: unknown;
    fuelRods: fuelRod[];
    controlRods: controlRod[];
  } = data;
  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section title="Reactor status">
          <LabeledList>
            <LabeledList.Item label="Integrity">
              <ProgressBar
                value={integrity / 100}
                ranges={{
                  good: [0.9, Infinity],
                  average: [0.5, 0.9],
                  bad: [-Infinity, 0.5],
                }}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Control Average">
              <Slider
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
              />
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
                }}>
                {toFixed(temperature, 2) + ' K'}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Reactor Shutdown">
              <Button
                color="bad"
                content="SCRAM"
                onClick={() => act('scram')}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Fuel Rods">
          {fuelRods !== null ? (
            fuelRods.map((fr, i) => {
              return RenderFuelRods(fr, i);
            })
          ) : (
            <p>No Fuel Rods Found!</p>
          )}
        </Section>
        <Section title="Control Rods">
          {controlRods !== null ? (
            controlRods.map((cr, i) => {
              return RenderControlRods(cr, i, act);
            })
          ) : (
            <p>No Control Rods in Data</p>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};

function RenderFuelRods(fR: fuelRod, index: number) {
  const low = Math.floor(fR.melting_point * 0.15);
  const med = Math.floor(fR.melting_point * 0.5);
  const high = Math.floor(fR.melting_point * 0.9);
  const bad = Math.floor(fR.melting_point * 1.2);
  return (
    <LabeledList>
      <LabeledList.Item label={`Rod #: ${index + 1}`}>
        <h3>Fissile Material</h3>
        <ProgressBar
          value={fR.life}
          minValue={0}
          maxValue={100}
          ranges={{
            bad: [-Infinity, 25],
            average: [25, 50],
            good: [50, 90],
            teal: [90, Infinity],
          }}>
          {toFixed(fR.life, 2) + ' %'}
        </ProgressBar>
        <h3>Temperature</h3>
        <ProgressBar
          value={logScale(fR.temperature)}
          minValue={0}
          maxValue={logScale(bad)}
          ranges={{
            teal: [-Infinity, logScale(low)],
            good: [logScale(low), logScale(med)],
            average: [logScale(med), logScale(high)],
            bad: [logScale(high), Infinity],
          }}>
          {toFixed(fR.temperature, 2) + ' K'}
        </ProgressBar>
      </LabeledList.Item>
    </LabeledList>
  );
}

function RenderControlRods(cR: controlRod, index: number, act: void) {
  return (
    <div>
      <p>Rod #: {index + 1}</p>
      <p>
        Height:
        <Slider
          minValue={cR.minHeight}
          maxValue={cR.maxHeight}
          value={cR.height}
          disabled
        />
      </p>
    </div>
  );
}
