package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.class_1741;
   import flash.geom.Rectangle;
   
   public class HeaderController extends ContainerController implements class_2211
   {
      
      private static const TAG_TITLE_ELEMENT:String = "_TITLE";
      
      private static const TAG_CONTROLS_ELEMENT:String = "_CONTROLS";
      
      public function HeaderController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         param4 |= 1;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get title() : ILabelWindow
      {
         return findChildByTag("_TITLE") as ILabelWindow;
      }
      
      public function get controls() : IItemListWindow
      {
         return findChildByTag("_CONTROLS") as IItemListWindow;
      }
      
      override public function set caption(param1:String) : void
      {
         super.caption = param1;
         try
         {
            title.text = param1;
         }
         catch(e:Error)
         {
         }
      }
      
      override public function set color(param1:uint) : void
      {
         super.color = param1;
         var _loc2_:Array = [];
         groupChildrenWithTag("_COLORIZE",_loc2_,-1);
         for each(var _loc3_ in _loc2_)
         {
            _loc3_.color = param1;
         }
      }
   }
}

