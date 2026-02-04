package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class BubbleController extends FrameController implements class_2872
   {
      
      private static const TAG_POINTER_UP_ELEMENT:String = "_POINTER_UP";
      
      private static const TAG_POINTER_DOWN_ELEMENT:String = "_POINTER_DOWN";
      
      private static const TAG_POINTER_LEFT_ELEMENT:String = "_POINTER_LEFT";
      
      private static const TAG_POINTER_RIGHT_ELEMENT:String = "_POINTER_RIGHT";
      
      private var var_81:String = "down";
      
      private var _pointerOffset:int = 0;
      
      public function BubbleController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get direction() : String
      {
         return var_81;
      }
      
      public function set direction(param1:String) : void
      {
         if(param1 != var_81)
         {
            var _loc2_:class_1741 = getChildByName(param1);
            throw new Error("Invalid pointer direction: \"" + param1 + "\"!");
         }
      }
      
      public function get pointerOffset() : int
      {
         return _pointerOffset;
      }
      
      public function set pointerOffset(param1:int) : void
      {
         var _loc2_:class_1741 = getChildByName(var_81);
         if(!_loc2_)
         {
            throw new Error("Invalid pointer direction: \"" + var_81 + "\"!");
         }
         if(var_81 == "up" || var_81 == "down")
         {
            _loc2_.x = width / 2 + param1;
         }
         else
         {
            _loc2_.y = height / 2 + param1;
         }
         _pointerOffset = param1;
      }
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         var _loc3_:Boolean = super.update(param1,param2);
         if(_pointerOffset != 0)
         {
            if(param1 == this)
            {
               if(param2.type == "WE_RESIZED")
               {
                  pointerOffset = _pointerOffset;
               }
            }
         }
         return _loc3_;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("direction",var_81));
         _loc1_.push(createProperty("pointer_offset",_pointerOffset));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "direction":
                  direction = _loc2_.value as String;
                  break;
               case "pointer_offset":
                  pointerOffset = _loc2_.value as int;
            }
         }
         super.properties = param1;
      }
   }
}

