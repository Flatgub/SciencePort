
/mob/living/carbon/alien/get_eye_protection()
	return ..() + 2 //potential cyber implants + natural eye protection

/mob/living/carbon/alien/get_ear_protection()
	return 2 //no ears

/mob/living/carbon/alien/hitby(atom/movable/AM, skipcatch, hitpush)
	..(AM, skipcatch = 1, hitpush = 0)


/*Code for aliens attacking aliens. Because aliens act on a hivemind, I don't see them as very aggressive with each other.
As such, they can either help or harm other aliens. Help works like the human help command while harm is a simple nibble.
In all, this is a lot like the monkey code. /N
*/
/mob/living/carbon/alien/attack_alien(mob/living/carbon/alien/M)
	if(!ticker || !ticker.mode)
		M << "You cannot attack people before the game has started."
		return

	if(isturf(loc) && istype(loc.loc, /area/start))
		M << "No attacking people at spawn, you jackass."
		return

	switch(M.a_intent)

		if ("help")
			AdjustSleeping(-5)
			resting = 0
			AdjustParalysis(-3)
			AdjustStunned(-3)
			AdjustWeakened(-3)
			visible_message("<span class='notice'>[M.name] nuzzles [src] trying to wake it up!</span>")

		if ("grab")
			grabbedby(M)

		else
			if (health > 0)
				M.do_attack_animation(src)
				playsound(loc, 'sound/weapons/bite.ogg', 50, 1, -1)
				var/damage = 1
				visible_message("<span class='danger'>[M.name] bites [src]!</span>", \
						"<span class='userdanger'>[M.name] bites [src]!</span>")
				adjustBruteLoss(damage)
				add_logs(M, src, "attacked")
				updatehealth()
			else
				M << "<span class='warning'>[name] is too injured for that.</span>"


/mob/living/carbon/alien/attack_larva(mob/living/carbon/alien/larva/L)
	return attack_alien(L)


/mob/living/carbon/alien/attack_hand(mob/living/carbon/human/M)
	if(..())	//to allow surgery to return properly.
		return 0

	switch(M.a_intent)
		if("help")
			help_shake_act(M)
		if("grab")
			grabbedby(M)
		if ("harm", "disarm")
			M.do_attack_animation(src)
			return 1
	return 0


/mob/living/carbon/alien/attack_paw(mob/living/carbon/monkey/M)
	if(..())
		if (stat != DEAD)
			var/obj/item/bodypart/affecting = get_bodypart(ran_zone(M.zone_selected))
			apply_damage(rand(1, 3), BRUTE, affecting)




/mob/living/carbon/alien/attack_animal(mob/living/simple_animal/M)
	if(..())
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		switch(M.melee_damage_type)
			if(BRUTE)
				adjustBruteLoss(damage)
			if(BURN)
				adjustFireLoss(damage)
			if(TOX)
				adjustToxLoss(damage)
			if(OXY)
				adjustOxyLoss(damage)
			if(CLONE)
				adjustCloneLoss(damage)
			if(STAMINA)
				adjustStaminaLoss(damage)
		updatehealth()

/mob/living/carbon/alien/attack_slime(mob/living/simple_animal/slime/M)
	if(..()) //successful slime attack
		var/damage = rand(5, 35)
		if(M.is_adult)
			damage = rand(10, 40)
		adjustBruteLoss(damage)
		add_logs(M, src, "attacked")
		updatehealth()

/mob/living/carbon/alien/ex_act(severity, target, origin)
	if(origin && istype(origin, /datum/spacevine_mutation) && isvineimmune(src))
		return
	..()
	switch (severity)
		if (1)
			gib()
			return

		if (2)
			take_overall_damage(60, 60)
			adjustEarDamage(30,120)

		if(3)
			take_overall_damage(30,0)
			if(prob(50))
				Paralyse(1)
			adjustEarDamage(15,60)

/mob/living/carbon/alien/soundbang_act(intensity = 1, stun_pwr = 1, damage_pwr = 5, deafen_pwr = 15)
	return 0

/mob/living/carbon/alien/acid_act(acidpwr, acid_volume)
	return 0//aliens are immune to acid.
