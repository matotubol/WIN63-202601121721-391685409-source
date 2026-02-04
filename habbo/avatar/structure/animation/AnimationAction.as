package com.sulake.habbo.avatar.structure.animation
{
   import com.sulake.core.utils.class_55;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class AnimationAction
   {
      
      public static const DEFAULT_OFFSET:Point = new Point(0,0);
      
      private var var_197:String;
      
      private var var_2790:Dictionary;
      
      private var var_3696:class_55 = new class_55();
      
      private var var_848:int;
      
      private var var_1045:Array;
      
      public function AnimationAction(param1:XML)
      {
         super();
         var_197 = String(param1.@id);
         var_2790 = new Dictionary();
         for each(var _loc8_ in param1.part)
         {
            var _loc10_:AnimationActionPart = new AnimationActionPart(_loc8_);
            var_2790[String(_loc8_["set-type"])] = null;
            var_848 = Math.max(var_848,null.frames.length);
         }
         var_1045 = [];
         for each(var _loc2_ in param1.offsets.frame)
         {
            var _loc5_:int = parseInt(_loc2_.@id);
            var_848 = Math.max(var_848,0);
            var _loc12_:class_55 = new class_55();
            var_3696[0] = null;
            for each(var _loc9_ in _loc2_.directions.direction)
            {
               var _loc6_:int = parseInt(_loc9_.@id);
               var _loc4_:class_55 = new class_55();
               null[0] = null;
               for each(var _loc7_ in _loc9_.bodypart)
               {
                  var _loc11_:String = String(_loc7_.@id);
                  var _loc13_:int = _loc7_.hasOwnProperty("@dx") ? parseInt(_loc7_.@dx) : 0;
                  var _loc14_:int = _loc7_.hasOwnProperty("@dy") ? parseInt(_loc7_.@dy) : 0;
                  null[null] = new Point(0,0);
               }
            }
            var_1045.push(0);
            var _loc3_:int = parseInt(_loc2_.@repeats);
         }
      }
      
      public function getPart(param1:String) : AnimationActionPart
      {
         return var_2790[param1] as AnimationActionPart;
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get parts() : Dictionary
      {
         return var_2790;
      }
      
      public function get frameCount() : int
      {
         return var_848;
      }
      
      public function getFrameBodyPartOffset(param1:int, param2:int, param3:String) : Point
      {
         var _loc7_:int = param2 % var_1045.length;
         var _loc4_:int = int(var_1045[_loc7_]);
         var _loc5_:class_55 = var_3696[_loc4_];
         if(_loc5_)
         {
            var _loc6_:class_55 = _loc5_[param1];
            if(_loc6_)
            {
               var _loc8_:Point = null[param3];
            }
         }
         return DEFAULT_OFFSET;
      }
   }
}

