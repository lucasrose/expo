import { requireNativeModule } from 'expo';
import { StatusBar } from 'expo-status-bar';
import { useCallback, useState } from 'react';
import { Button, StyleSheet, Text, View } from 'react-native';

const MyExpoModule = requireNativeModule('ExpoImage');

const runs = 100_000;

function runNumberBenchmark() {
  console.log('--------- BEGINNING NUMBER BENCHMARKS ---------');

  // Lazy loading
  MyExpoModule.addNumbers(0, 1);

  let expoTime = 0;
  {
    console.log(`Starting ExpoModule benchmark...`);
    const start = performance.now();
    let num = 0;
    for (let i = 0; i < runs; i++) {
      num = MyExpoModule.addNumbers(num, 5);
    }
    const end = performance.now();
    expoTime = (end - start).toFixed(2);
    console.log(`ExpoModule took ${expoTime}ms to run addNumbers(...) ${runs}x!`);
  }
  const turboTime = 0;
  // {
  //   console.log(`Starting TurboModule benchmark...`);
  //   const start = performance.now();
  //   let num = 0;
  //   for (let i = 0; i < runs; i++) {
  //     num = MyTurboModule.addNumbers(num, 5);
  //   }
  //   const end = performance.now();
  //   turboTime = (end - start).toFixed(2);
  //   console.log(`TurboModule took ${turboTime}ms to run addNumbers(...) ${runs}x!`);
  // }
  const nitroTime = 0;
  // {
  //   console.log(`Starting NitroModule benchmark...`);
  //   const start = performance.now();
  //   let num = 0;
  //   for (let i = 0; i < runs; i++) {
  //     num = MyNitroModule.addNumbers(num, 5);
  //   }
  //   const end = performance.now();
  //   nitroTime = (end - start).toFixed(2);
  //   console.log(`NitroModule took ${nitroTime}ms to run addNumbers(...) ${runs}x!`);
  // }
  console.log('--------- FINISHED NUMBER BENCHMARKS! ---------');
  return { expoTime, turboTime, nitroTime };
}

function runStringsBenchmark() {
  console.log('--------- BEGINNING STRING BENCHMARKS ---------');

  // Lazy loading
  MyExpoModule.addStrings('hello', 'world');

  let expoTime = 0;
  {
    console.log(`Starting ExpoModule benchmark...`);
    const start = performance.now();
    for (let i = 0; i < runs; i++) {
      const x = MyExpoModule.addStrings('hello ', 'world');
    }
    const end = performance.now();
    expoTime = (end - start).toFixed(2);
    console.log(`ExpoModule took ${expoTime}ms to run addNumbers(...) ${runs}x!`);
  }
  const turboTime = 0;
  // {
  //   console.log(`Starting TurboModule benchmark...`)
  //   const start = performance.now()
  //   for (let i = 0; i < runs; i++) {
  //     const x = MyTurboModule.addStrings('hello ', 'world')
  //   }
  //   const end = performance.now()
  //   turboTime = (end - start).toFixed(2)
  //   console.log(`TurboModule took ${turboTime}ms to run addStrings(...) ${runs}x!`)
  // }
  const nitroTime = 0;
  // {
  //   console.log(`Starting NitroModule benchmark...`)
  //   const start = performance.now()
  //   for (let i = 0; i < runs; i++) {
  //     const x = MyNitroModule.addStrings('hello ', 'world')
  //   }
  //   const end = performance.now()
  //   nitroTime = (end - start).toFixed(2)
  //   console.log(`NitroModule took ${nitroTime}ms to run addStrings(...) ${runs}x!`)
  // }
  console.log('--------- FINISHED STRING BENCHMARKS! ---------');
  return { expoTime, turboTime, nitroTime };
}

export default function App() {
  const [numberTimes, setNumberTimes] = useState();
  const [stringTimes, setStringTimes] = useState();

  const startBenchmarks = useCallback(() => {
    setNumberTimes(runNumberBenchmark());

    setStringTimes(runStringsBenchmark());
  }, []);

  return (
    <View style={styles.container}>
      <Text style={{ fontWeight: 'bold', size: 24 }}>
        ExpoModules vs TurboModules vs NitroModules
      </Text>

      <View style={{ height: 50 }} />

      <Text style={{ fontWeight: 'bold', size: 24 }}>Calling addNumbers(...) 100.000x</Text>
      <View style={{ alignItems: 'flex-end' }}>
        <Text>
          ExpoModule.addNumbers(...) took{' '}
          <Text style={{ fontWeight: 'bold' }}>{numberTimes?.expoTime}ms</Text>
        </Text>
        {/* <Text>
          TurboModule.addNumbers(...) took{' '}
          <Text style={{ fontWeight: 'bold' }}>{numberTimes?.turboTime}ms</Text>
        </Text>
        <Text>
          NitroModule.addNumbers(...) took{' '}
          <Text style={{ fontWeight: 'bold' }}>{numberTimes?.nitroTime}ms</Text>
        </Text> */}
      </View>

      <View style={{ height: 50 }} />

      <Text style={{ fontWeight: 'bold', size: 24 }}>Calling addStrings(...) 100.000x</Text>
      <View style={{ alignItems: 'flex-end' }}>
        <Text>
          ExpoModule.addStrings(...) took{' '}
          <Text style={{ fontWeight: 'bold' }}>{stringTimes?.expoTime}ms</Text>
        </Text>
        {/* <Text>
          TurboModule.addStrings(...) took{' '}
          <Text style={{ fontWeight: 'bold' }}>{stringTimes?.turboTime}ms</Text>
        </Text>
        <Text>
          NitroModule.addStrings(...) took{' '}
          <Text style={{ fontWeight: 'bold' }}>{stringTimes?.nitroTime}ms</Text>
        </Text> */}
      </View>

      <Button title="Start" onPress={startBenchmarks} />

      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
