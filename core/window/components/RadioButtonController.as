package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.class_1741;
   import flash.geom.Rectangle;
   
   public class RadioButtonController extends SelectableController implements IRadioButtonWindow
   {
      
      protected static const TEXT_FIELD_NAME:String = "_CAPTION_TEXT";
      
      public function RadioButtonController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         param4 |= 1;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function set caption(param1:String) : void
      {
         super.caption = param1;
         var _loc2_:class_1741 = getChildByName("_CAPTION_TEXT");
         if(_loc2_ != null)
         {
            _loc2_.caption = caption;
         }
      }
      
      override public function setRectangle(param1:int, param2:int, param3:int, param4:int) : void
      {
         super.setRectangle(param1,param2,param3,param4);
         var _loc5_:ITextWindow = getChildByName("_CAPTION_TEXT") as ITextWindow;
         if(_loc5_ != null)
         {
            _loc5_.width = param3;
         }
      }
   }
}

