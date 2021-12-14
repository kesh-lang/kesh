// https://github.com/kesh-lang/kesh/wiki/Documentation#modules

// https://github.com/kesh-lang/kesh/wiki/Documentation#exports

const answer = 42
const query = () => answer

export { answer, query }


// https://github.com/kesh-lang/kesh/wiki/Documentation#imports

import merge from 'lodash.merge'

import { query } from 'oracle.kesh'

query('What is the answer to the ultimate question of life, the universe, and everything?')
// 42
