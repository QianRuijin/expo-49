package abi49_0_0.com.swmansion.reanimated;

import abi49_0_0.com.facebook.react.bridge.ReadableArray;
import abi49_0_0.com.facebook.react.bridge.ReadableMap;
import abi49_0_0.com.facebook.react.bridge.ReadableMapKeySetIterator;
import java.util.HashMap;
import java.util.Map;

public class Utils {

  public static boolean isChromeDebugger = false;

  public static Map<String, Integer> processMapping(ReadableMap style) {
    ReadableMapKeySetIterator iter = style.keySetIterator();
    HashMap<String, Integer> mapping = new HashMap<>();
    while (iter.hasNextKey()) {
      String propKey = iter.nextKey();
      int nodeIndex = style.getInt(propKey);
      mapping.put(propKey, nodeIndex);
    }
    return mapping;
  }

  public static int[] processIntArray(ReadableArray ary) {
    int size = ary.size();
    int[] res = new int[size];
    for (int i = 0; i < size; i++) {
      res[i] = ary.getInt(i);
    }
    return res;
  }

  public static String simplifyStringNumbersList(String list) {
    // transforms string: '[1, 2, 3]' -> '1 2 3'
    // to make usage of std::istringstream in C++ easier
    return list.replace(",", "").replace("[", "").replace("]", "");
  }
}
