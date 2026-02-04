package com.sulake.habbo.roomevents.wired_setup.conditions
{
   public class FurnisHaveNoAvatars extends FurnisHaveAvatars
   {
      
      public function FurnisHaveNoAvatars()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.NOT_FURNIS_HAVE_AVATARS;
      }
   }
}

