package com.sulake.habbo.groups.events
{
   import flash.events.Event;
   
   public class HabboGroupsEditorData extends Event
   {
      
      public static const EDIT_INFO:String = "HGE_EDIT_INFO";
      
      public function HabboGroupsEditorData(param1:Boolean = false, param2:Boolean = false)
      {
         super("HGE_EDIT_INFO",param1,param2);
      }
   }
}

