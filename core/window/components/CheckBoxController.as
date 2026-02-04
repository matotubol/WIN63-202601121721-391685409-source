package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import flash.geom.Rectangle;
   
   public class CheckBoxController extends SelectableController implements class_1885
   {
      
      protected static const TEXT_FIELD_NAME:String = "_CAPTION_TEXT";
      
      public function CheckBoxController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
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
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         if(param1 == this)
         {
            var _loc3_:* = param2.type;
            if("WME_UP" === _loc3_)
            {
               if(isSelected)
               {
                  unselect();
               }
               else
               {
                  select();
               }
            }
         }
         return super.update(param1,param2);
      }
   }
}

