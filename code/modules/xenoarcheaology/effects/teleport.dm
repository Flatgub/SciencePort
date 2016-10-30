/datum/artifact_effect/teleport
	name = "teleport"
	effect_type = EFFECT_BLUESPACE

/datum/artifact_effect/teleport/DoEffectTouch(var/mob/user)
	var/weakness = GetAnomalySusceptibility(user)
	if(prob(100 * weakness))
		user << "\red You are suddenly zapped away elsewhere!"
		if (user.buckled)
			user.buckled.unbuckle_mob()


		new /obj/effect/particle_effect/sparks(get_turf(user))

		//var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
		//sparks.set_up(3, 0, get_turf(user))
		//sparks.start()

		user.Move(pick(range(50, get_turf(holder))))

		new /obj/effect/particle_effect/sparks(get_turf(user))
		//sparks = new /datum/effect/effect/system/spark_spread()
		//sparks.set_up(3, 0, user.loc)
		//sparks.start()

/datum/artifact_effect/teleport/DoEffectAura()
	if(holder)
		var/turf/T = get_turf(holder)
		for (var/mob/living/M in range(src.effectrange,T))
			var/weakness = GetAnomalySusceptibility(M)
			if(prob(100 * weakness))
				M << "\red You are displaced by a strange force!"
				if(M.buckled)
					M.buckled.unbuckle_mob()

				new /obj/effect/particle_effect/sparks(get_turf(M))

				//var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
				//sparks.set_up(3, 0, get_turf(M))
				//sparks.start()

				M.Move(pick(range(50, T)))

				new /obj/effect/particle_effect/sparks(get_turf(M))

				//sparks = new /datum/effect/effect/system/spark_spread()
				//sparks.set_up(3, 0, M.loc)
				//sparks.start()

/datum/artifact_effect/teleport/DoEffectPulse()
	if(holder)
		var/turf/T = get_turf(holder)
		for (var/mob/living/M in range(src.effectrange, T))
			var/weakness = GetAnomalySusceptibility(M)
			if(prob(100 * weakness))
				M << "\red You are displaced by a strange force!"
				if(M.buckled)
					M.buckled.unbuckle_mob()

				new /obj/effect/particle_effect/sparks(get_turf(M))
				//var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
				//sparks.set_up(3, 0, get_turf(M))
				//sparks.start()

				M.Move(pick(range(50, T)))

				new /obj/effect/particle_effect/sparks(get_turf(M))

				//sparks = new /datum/effect/effect/system/spark_spread()
				//sparks.set_up(3, 0, M.loc)
				//sparks.start()
