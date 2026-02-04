package com.sulake.core.window.dynamicstyle
{
   import flash.utils.Dictionary;
   
   public class class_3171
   {
      
      private static var _styles:Dictionary;
      
      public function class_3171()
      {
         super();
      }
      
      public static function getStyle(param1:String) : DynamicStyle
      {
         if(!_styles)
         {
            fillStyleTable();
         }
         if(param1 in _styles)
         {
            return _styles[param1];
         }
         return new DynamicStyle();
      }
      
      private static function fillStyleTable() : void
      {
         _styles = new Dictionary();
         var _loc2_:DynamicStyle = new DynamicStyle("lifted_hover");
         _loc2_.defaultStyles = {};
         _loc2_.pressedSyles = {
            "offsetX":1,
            "colorTransform":[1,0.7,0.7,0.7,0,0,0,0]
         };
         _loc2_.var_1327 = {
            "offsetY":-1,
            "offsetX":-1
         };
         var _loc8_:DynamicStyle = new DynamicStyle();
         _loc8_.defaultStyles = {
            "etchingColor":1207959552,
            "etchingPoint":[1,1]
         };
         _loc8_.var_1327 = {
            "etchingColor":2147483648,
            "etchingPoint":[2,2]
         };
         _loc8_.pressedSyles = {
            "etchingColor":1207959552,
            "etchingPoint":[-1,-1]
         };
         _loc2_.var_1434["#icon"] = _loc8_;
         var _loc4_:DynamicStyle = new DynamicStyle("brightness_and_shadow_under");
         _loc4_.defaultStyles = {};
         var _loc9_:DynamicStyle = new DynamicStyle();
         _loc9_.defaultStyles = {
            "etchingColor":1207959552,
            "etchingPoint":[0,1]
         };
         _loc9_.pressedSyles = {
            "etchingColor":2147483648,
            "etchingPoint":[0,-1],
            "offsetY":-1,
            "colorTransform":[0.7,0.7,0.7,1,0,0,0,0]
         };
         _loc9_.var_1327 = {
            "etchingColor":1207959552,
            "etchingPoint":[0,1],
            "colorTransform":[1,1,1,1,77,77,77,0]
         };
         _loc4_.var_1434["#icon"] = _loc9_;
         var _loc5_:DynamicStyle = new DynamicStyle();
         _loc5_.defaultStyles = {
            "etchingColor":1207959552,
            "etchingPoint":[0,1]
         };
         _loc5_.pressedSyles = {
            "etchingColor":2147483648,
            "etchingPoint":[0,0],
            "colorTransform":[0.9,0.9,0.9,1,0,0,0,0]
         };
         _loc5_.var_1327 = {
            "etchingColor":1207959552,
            "etchingPoint":[0,1],
            "colorTransform":[1,1,1,1,77,77,77,0]
         };
         _loc5_.var_3732 = {"colorTransform":[0.5,0.5,0.5,0.7,0,0,0,0]};
         _loc4_.var_1434["#bg"] = _loc5_;
         var _loc3_:DynamicStyle = new DynamicStyle("brightness_and_shadow_under_gentle");
         _loc3_.defaultStyles = {};
         var _loc6_:DynamicStyle = new DynamicStyle();
         _loc6_.defaultStyles = {
            "etchingColor":1207959552,
            "etchingPoint":[0,1]
         };
         _loc6_.pressedSyles = {
            "etchingColor":2147483648,
            "etchingPoint":[0,-1],
            "offsetY":-1,
            "colorTransform":[0.8,0.8,0.8,1,0,0,0,0]
         };
         _loc6_.var_1327 = {
            "etchingColor":1207959552,
            "etchingPoint":[0,1],
            "colorTransform":[1.1,1.1,1.1,1,30,30,30,0]
         };
         _loc3_.var_1434["#icon"] = _loc6_;
         var _loc1_:DynamicStyle = new DynamicStyle("button");
         _loc1_.defaultStyles = {};
         var _loc7_:DynamicStyle = new DynamicStyle();
         _loc7_.defaultStyles = {
            "etchingColor":1207959552,
            "etchingPoint":[0,0]
         };
         _loc7_.pressedSyles = {
            "etchingColor":2147483648,
            "etchingPoint":[0,0],
            "offsetY":1,
            "colorTransform":[0.8,0.8,0.8,1,0,0,0,0]
         };
         _loc7_.var_1327 = {
            "etchingColor":1207959552,
            "etchingPoint":[0,0],
            "colorTransform":[1.1,1.1,1.1,1,15,15,15,0]
         };
         _loc1_.var_1434["#icon"] = _loc7_;
         _styles["lifted_hover"] = _loc2_;
         _styles["brightness_and_shadow_under"] = _loc4_;
         _styles["brightness_and_shadow_under_gentle"] = _loc3_;
         _styles["button"] = _loc1_;
      }
   }
}

